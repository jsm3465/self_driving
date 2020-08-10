import threading
import pycuda.driver as cuda
import cv2
import numpy as np
import ctypes
import tensorrt as trt
import random
import colorsys

# -------------------------------------------------------------------------------------
# CUDA 드라이버를 초기화하고 입력 이미지를 얻어 TrtSSD 클래스에게 감지를 위임하는 스레드 클래스
# -------------------------------------------------------------------------------------
class TrtThread(threading.Thread):
    # 정적 멤버 필드 선언
    INPUT_TYPE_IMAGE = 0
    INPUT_TYPE_VIDEO = 1
    INPUT_TYPE_USBCAM = 2

    # 생성자 선언
    def __init__(self, enginePath, inputType, inputSource, conf_th, condition):
        threading.Thread.__init__(self)
        self.enginePath = enginePath
        self.inputSource = inputSource
        self.inputType = inputType
        self.condition = condition
        self.conf_th = conf_th
        self.cuda_ctx = None
        self.trt_ssd = None
        self.img = None
        self.boxes = None
        self.confs = None
        self.clss = None
        self.running = True

    # start() 메소드가 호출되면 실행
    def run(self):
        # CUDA 드라이버 초기화
        cuda.init()
        # GPU 0의 CUDA Context 생성
        self.cuda_ctx = cuda.Device(0).make_context()
        # 사물 감지를 수행하는 TrtSSD 생성
        self.trt_ssd = TrtSSD(self.enginePath)
        # 입력 소스별로 이미지를 읽고 TrTSSD에게 감지 요청
        while self.running:
            # 입력 소스가 이미지일 경우
            if self.inputType == TrtThread.INPUT_TYPE_IMAGE:
                img = self.inputSource
                boxes, confs, clss = self.trt_ssd.detect(img, self.conf_th)
                # condition 동기화
                with self.condition:
                    # 감지 결과 복제
                    self.img, self.boxes, self.confs, self.clss = img, boxes, confs, clss
                    # wait()로 대기중인 스레드에게 통지
                    self.condition.notify()
                self.running = False
            # 입력 소스가 비디오일 경우
            elif self.inputType == TrtThread.INPUT_TYPE_VIDEO or self.inputType == TrtThread.INPUT_TYPE_USBCAM:
                videoCapture = self.inputSource
                retval, img = videoCapture.read()

                if retval is True:
                    boxes, confs, clss = self.trt_ssd.detect(img, self.conf_th)
                    with self.condition:
                        self.img, self.boxes, self.confs, self.clss = img, boxes, confs, clss
                        self.condition.notify()
                else:
                    self.running = False

        # TrtSSD 소멸
        del self.trt_ssd
        # CUDA Context 소멸
        self.cuda_ctx.pop()
        del self.cuda_ctx

    # 감지 결과를 호출하는 곳으로 전달
    def getDetectResult(self):
        return self.img, self.boxes, self.confs, self.clss

    # 스레드 중지
    def stop(self):
        self.running = False
        self.join()

# -------------------------------------------------------------------------------------
# SSD 모델로부터 생성된 엔진으로 사물을 감지하는 클래스
# -------------------------------------------------------------------------------------
class TrtSSD(object):
    # 생성자 선언
    def __init__(self, enginePath):
        # 엔진 파일 경로 필드 선언 및 초기화
        self.enginePath = enginePath
        # 라이브러리 로딩
        ctypes.CDLL("/home/jetson/MyWorkspace/jetracer/lib/libflattenconcat.so")
        # 로거 필드 선언 및 초기화
        self.trtLogger = trt.Logger(trt.Logger.INFO)
        # TensorRT 로거 세팅
        trt.init_libnvinfer_plugins(self.trtLogger, '')
        # 엔진 필드 선언 및 초기화
        self.engine = self.loadEngine()
        # host inputs/outputs 필드 및 초기화
        self.hostInputs = []
        self.hostOutputs = []
        # cuda inputs/outputs 필드 및 초기화
        self.cudaInputs = []
        self.cudaOutputs = []
        # bindings 필드 선언 및 초기화
        self.bindings = []
        # 엔지 실행 환경인 context 필드 선언 및 초기화
        self.context = self.createContext()
        # cuda 스트림 필드 선언 및 초기화
        self.stream = cuda.Stream()

    # 엔진 파일 로딩
    def loadEngine(self):
        with open(self.enginePath, 'rb') as f, trt.Runtime(self.trtLogger) as runtime:
            return runtime.deserialize_cuda_engine(f.read())

    # 엔진 실행 환경인 context 필드 생성
    def createContext(self):
        for binding in self.engine:
            size = trt.volume(self.engine.get_binding_shape(binding)) * self.engine.max_batch_size
            host_mem = cuda.pagelocked_empty(size, np.float32)
            cuda_mem = cuda.mem_alloc(host_mem.nbytes)
            self.bindings.append(int(cuda_mem))
            if self.engine.binding_is_input(binding):
                self.hostInputs.append(host_mem)
                self.cudaInputs.append(cuda_mem)
            else:
                self.hostOutputs.append(host_mem)
                self.cudaOutputs.append(cuda_mem)
        return self.engine.create_execution_context()

    # 사물 감지하기
    def detect(self, img, conf_th=0.3):
        img_resized = self.preprocessTRT(img)
        np.copyto(self.hostInputs[0], img_resized.ravel())
        # host to device 메모리 복사
        cuda.memcpy_htod_async(self.cudaInputs[0], self.hostInputs[0], self.stream)
        self.context.execute_async(batch_size=1, bindings=self.bindings, stream_handle=self.stream.handle)
        # device to host 메모리 복사
        cuda.memcpy_dtoh_async(self.hostOutputs[1], self.cudaOutputs[1], self.stream)
        cuda.memcpy_dtoh_async(self.hostOutputs[0], self.cudaOutputs[0], self.stream)
        self.stream.synchronize()
        output = self.hostOutputs[0]
        return self.postprocessTRT(img, output, conf_th)

    # 입력 전처리
    def preprocessTRT(self, img, shape=(300, 300)):
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img = cv2.resize(img, shape)
        img = img.transpose((2, 0, 1)).astype(np.float32)
        img = (2.0/255.0) * img - 1.0
        return img

    # 출력 후처리
    def postprocessTRT(self, img, output, conf_th, output_layout=7):
        img_h, img_w, _ = img.shape
        boxes, confs, clss = [], [], []
        for prefix in range(0, len(output), output_layout):
            #index = int(output[prefix+0])
            conf = float(output[prefix+2])
            if conf < conf_th:
                continue
            x1 = int(output[prefix+3] * img_w)
            y1 = int(output[prefix+4] * img_h)
            x2 = int(output[prefix+5] * img_w)
            y2 = int(output[prefix+6] * img_h)
            cls = int(output[prefix+1])
            boxes.append((x1, y1, x2, y2))
            confs.append(conf)
            clss.append(cls)
        return boxes, confs, clss

    def __del__(self):
        # cuda 메모리 해제
        del self.stream
        del self.cudaOutputs
        del self.cudaInputs

# --------------------------------------------------------------------------
# 감지된 사물의 바운딩 박스(테두리 사각형)를 드로잉하는 클래스 선언
# --------------------------------------------------------------------------
class BBoxVisualization():
    # 생성자 선언
    def __init__(self, cls_dict):
        self.cls_dict = cls_dict
        self.colors = self.genColors(len(cls_dict))
        self.textFont = cv2.FONT_HERSHEY_PLAIN
        self.textScale = 2.0
        self.textThickness = 1
        self.textColor = (255, 255, 255)

    # 분류 수만큼 랜덤 색상을 정해서 리스트로 리턴 [(blue, green, red), ... ]
    def genColors(self, num_colors):
        hsvs = [[float(x) / num_colors, 1., 0.7] for x in range(num_colors)]
        random.seed(1234)
        random.shuffle(hsvs)
        rgbs = list(map(lambda x: list(colorsys.hsv_to_rgb(*x)), hsvs))
        bgrs = [(int(rgb[2] * 255), int(rgb[1] * 255), int(rgb[0] * 255)) for rgb in rgbs]
        return bgrs

    # 이미지 위에 바운딩 박스를 드로잉
    def drawBboxes(self, img, boxes, confs, clss):
        for bb, cf, cl in zip(boxes, confs, clss):
            print("object detect!!")
            cl = int(cl)
            x_min, y_min, x_max, y_max = bb[0], bb[1], bb[2], bb[3]
            color = self.colors[cl]
            cv2.rectangle(img, (x_min, y_min), (x_max, y_max), color, 2)
            txt_loc = (max(x_min+2, 0), max(y_min+2, 0))
            cls_name = self.cls_dict.get(cl, 'CLS{}'.format(cl))
            txt = '{} {:.2f}'.format(cls_name, cf)
            img = self.drawClassName(img, txt, txt_loc, color)
        return img

    # 이미지 위에 분류명 신뢰도 텍스트를 박싱해서 드로잉
    def drawClassName(self, img, text, topleft, color):
        assert img.dtype == np.uint8
        img_h, img_w, _ = img.shape
        if topleft[0] >= img_w or topleft[1] >= img_h:
            return img
        margin = 3
        size = cv2.getTextSize(text, self.textFont, self.textScale, self.textThickness)
        w = size[0][0] + margin * 2
        h = size[0][1] + margin * 2
        patch = np.zeros((h, w, 3), dtype=np.uint8)
        patch[...] = color
        cv2.putText(patch, text, (margin+1, h-margin-2), self.textFont, self.textScale, self.textColor, self.textThickness, cv2.LINE_8)
        cv2.rectangle(patch, (0, 0), (w-1, h-1), (0, 0, 0), 1)
        w = min(w, img_w - topleft[0])
        h = min(h, img_h - topleft[1])
        roi = img[topleft[1]:topleft[1]+h, topleft[0]:topleft[0]+w, :]
        cv2.addWeighted(patch[0:h, 0:w, :], 0.5, roi, 1 - 0.5, 0, roi)
        return img

    # 이미지위에 초당 프레임 수 드로잉
    def drawFps(self, img, fps):
        font = cv2.FONT_HERSHEY_PLAIN
        line = cv2.LINE_AA
        fps_text = 'FPS: {:.2f}'.format(fps)
        cv2.putText(img, fps_text, (11, 20), font, 1.0, (32, 32, 32), 1, line)
        cv2.putText(img, fps_text, (10, 20), font, 1.0, (240, 240, 240), 1, line)
        return img