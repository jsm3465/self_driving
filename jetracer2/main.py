import sys
project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from mqtt.subscriber import MqttSubscriber
from mqtt.Camerapublisher import ImageMqttPusblisher
from mqtt.publisher import MqttPublisher

from AI_Rover import AI_Rover

from utils import camera
from linedetect.line_detect import LineDetector
import pycuda.driver as cuda

from utils import trt_ssd_object_detect as trt
from utils.object_label_map import CLASSES_DICT
import time
import cv2


enginePath = project_path + "/models/ssd_mobilenet_v2_object_model/tensorrt_fp16.engine"

# ======================= MQTT ================================
mqttSub = MqttSubscriber("192.168.3.223", topic="/order/rover1/#")
mqttSub.start()

campub = ImageMqttPusblisher("192.168.3.223", pubTopic="/camerapub/rover1")
campub.connect()

rover = AI_Rover()

sensorpub = MqttPublisher(rover, "192.168.3.223", topic="/sensor/rover1")
sensorpub.start()


# ==================== object detection ========================
conf_th = 0.6
fps = 0.0
enginePath = project_path + "/models/ssd_mobilenet_v2_object_model/tensorrt_fp16.engine"

# ===============================================================
# 카메라 동영상 읽어오기
Camera = camera.Video_Setting()
capture = Camera.video_read()

# 차선 인식 클래스
line_detector = LineDetector()

# CUDA 드라이버 초기화
cuda.init()
# GPU 0의 CUDA Context 생성
cuda_ctx = cuda.Device(0).make_context()

# 객체 인식 클래스
trt_ssd = trt.TrtSSD(enginePath)
vis = trt.BBoxVisualization(CLASSES_DICT)

flag = 0

# 시작 시간
tic = time.time()

# 카메라 영상 캡처
try:
    while True:
        retval, frame = capture.read()
        if not retval:
            print("video capture fail")
            break

        # 웹에서 주행 모드 커맨드 받아옴
        # flag - (1: 자율 주행 모드, 2: 자율 주행 모드 정지, 3: 조종 모드)
        if mqttSub.message != None:
            topic = mqttSub.message.topic
            message = str(mqttSub.message.payload, encoding="UTF-8")
            # print(topic, " : ", message)

            if "mode1" in topic:
                if "start" in message:
                    flag = 1
                elif "end" in message:
                    flag = 2
            elif "mode2" in topic:
                flag = 3
            else:
                pass


            # ------------------ 자율 주행 모드 ON -----------------
            if flag == 1:
                # print("자율 주행 ON")
                dist = rover.distance.read()
                # print(dist)

                if dist < 15:
                    rover.stop()
                else:
                    rover.forward()

                # 자율 주행 카메라 영상 처리
                # ---- 1. 차선 인식 ----
                # 차선 인식 화면
                line = line_detector.line_camera(frame)

                # 서보 모터 각도 조절
                rover.set_angle(line_detector.angle)

                # ---- 2. 객체 인식 ----
                boxes, confs, clss = trt_ssd.detect(frame, conf_th)
                print(clss, " : ", boxes)
                # 감지 결과 출력
                obj = vis.drawBboxes(frame, boxes, confs, clss)

                frame = cv2.addWeighted(line, 0.5, obj, 0.5, 0)

            # ------------------ 자율 주행 모드 OFF -----------------
            elif flag == 2:
                rover.stop()

            #  ------------------ 조작 모드 -----------------
            elif flag == 3:
                print("mode2 실행")
                if "direction" in topic:
                    if message == "forward":
                        rover.forward()
                    elif message == "backward":
                        rover.backward()
                    elif message == "stop":
                        rover.stop()
                    elif message == "left":
                        rover.handle_left()
                    elif message == "right":
                        rover.handle_right()
                    elif message == "refront":
                        rover.handle_refront()
            else:
                pass

        # 초당 프레임 수 드로잉
        img = vis.drawFps(frame, fps)

        # 초당 프레임 수 계산
        toc = time.time()
        curr_fps = 1.0 / (toc - tic)
        fps = curr_fps if fps == 0.0 else (fps * 0.95 + curr_fps * 0.05)
        tic = toc

        campub.sendBase64(img)

except KeyboardInterrupt:
    pass

finally:
    rover.stop()
    rover.set_angle(0)
    cuda_ctx.pop()
    del cuda_ctx