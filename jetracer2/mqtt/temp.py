import cv2
import paho.mqtt.client as mqtt
import threading
import base64
import time

import sys
project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from utils import camera
from linedetect.line_detect import LineDetector
import pycuda.driver as cuda


from utils import trt_ssd_object_detect as trt
from utils.object_label_map import CLASSES_DICT

class ImageMqttPusblisher:
    def __init__(self, rover, mqttSub, brokerIp=None, brokerPort=1883, pubTopic=None):
        self.brokerIp = brokerIp
        self.brokerPort = brokerPort
        self.pubTopic = pubTopic
        self.client = mqtt.Client()
        self.client.on_connect = self.__on_connect
        self.client.on_disconnect = self.__on_disconnect
        self.__stop = False
        self.rover = rover
        self.mqttsub = mqttSub
        self.send = False

    def connect(self):
        self.client.connect(self.brokerIp, self.brokerPort)
        thread = threading.Thread(target=self.__run)
        thread.start()

    def __run(self):

        # 1.그냥 쓴다
        # self.client.loop_forever()

        # 2.스레드처리인데 이상함
        self.client.loop_start()
        while not self.__stop:
            if self.rover.frame is None:
                continue
            if self.send:
                self.sendBase64(self.rover.frame)
                self.send = False
                self.mqttsub.receive = False
                # print(self.send)

        self.client.loop_stop()

        # 3. 여기에 다 때려박는다
        # # CUDA 드라이버 초기화
        # cuda.init()
        # # GPU 0의 CUDA Context 생성
        # cuda_ctx = cuda.Device(0).make_context()
        # self.client.loop_start()

        # # ==================== object detection ========================
        # conf_th = 0.6
        # fps = 0.0
        # enginePath = project_path + "/models/ssd_mobilenet_v2_model_47396/tensorrt_fp16.engine"
        #
        # # 객체 인식 클래스
        # trt_ssd = trt.TrtSSD(enginePath)
        # vis = trt.BBoxVisualization(CLASSES_DICT)
        #
        # # 시작 시간
        # tic = time.time()
        #
        # # 카메라 동영상 읽어오기 하세요
        # Camera = camera.Video_Setting()
        # capture = Camera.video_read()
        #
        # try:
        #     while True:
        #         retval, frame = capture.read()
        #         if not retval:
        #             print("video capture fail")
        #             break
        #
        #         # ---- 2. 객체 인식 ----
        #         boxes, confs, clss = trt_ssd.detect(frame, conf_th)
        #
        #         # 감지 결과 출력
        #         obj = vis.drawBboxes(frame, boxes, confs, clss)
        #
        #         frame = cv2.addWeighted(frame, 0.5, obj, 0.5, 0)
        #
        #         # 초당 프레임 수 드로잉
        #         img = vis.drawFps(frame, fps)
        #
        #         # 초당 프레임 수 계산
        #         toc = time.time()
        #         curr_fps = 1.0 / (toc - tic)
        #         fps = curr_fps if fps == 0.0 else (fps * 0.95 + curr_fps * 0.05)
        #
        #         # if self.mqttsub.receive:
        #             # print("camera send")
        #         self.sendBase64(img)
        #             # self.mqttsub.receive = False
        #             # print("campub.send = True")
        #         tic = toc
        # except Exception:
        #     pass
        #
        # finally:
        #     cuda_ctx.pop()
        #     del cuda_ctx
        #     self.client.loop_stop()

    def __on_connect(self, client, userdata, flags, rc):
        print("ImageMqttClient mqtt broker connected")

    def __on_disconnect(self, client, userdata, rc):
        print("ImageMqttClient mqtt broker disconnected")

    def disconnect(self):
        self.client.disconnect()
        self.__stop = True

    def sendBase64(self, frame):
        if self.client is None:
            print("1")
            return
        # MQTT Broker가 연결되어 있지 않을 경우
        if not self.client.is_connected():
            print("2")
            return
        # JPEG 포맷으로 인코딩
        retval, bytes = cv2.imencode(".jpg", frame)
        # 인코딩이 실패났을 경우
        if not retval:
            print("image encoding fail")
            return
        # Base64 문자열로 인코딩
        b64_bytes = base64.b64encode(bytes)
        # MQTT Broker에 보내기
        self.client.publish(self.pubTopic, b64_bytes)
        print("camera send")

if __name__ == "__main__":
    # videoPath = "../resource/video1.mp4"
    # videoCapture = cv2.VideoCapture(videoPath)
    videoCapture = cv2.VideoCapture(0)
    # videoCapture.set(cv2.CAP_PROP_FRAME_WIDTH, 320)
    # videoCapture.set(cv2.CAP_PROP_FRAME_HEIGHT, 240)
    imageMqttPusblisher = ImageMqttPusblisher("192.168.3.250", 1883, "/camerapub")
    imageMqttPusblisher.connect()
    while True:
        if videoCapture.isOpened():
            retval, frame = videoCapture.read()
            if not retval:
                # print("video capture fail")
                break
            imageMqttPusblisher.sendBase64(frame)
            # print("send")
        else:
            break

    imageMqttPusblisher.disconnect()
    videoCapture.release()











