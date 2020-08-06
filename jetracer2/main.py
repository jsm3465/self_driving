import sys

from mqtt.subscriber import MqttSubscriber
from mqtt.Camerapublisher import ImageMqttPusblisher
from mqtt.publisher import MqttPublisher

from AI_Rover import AI_Rover

from utils import camera
# import cam.main03_detect_from_image as cam
from linedetect.line_detect import LineDetector
import pycuda.driver as cuda

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)
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
enginePath = project_path + "/models/ssd_mobilenet_v2_object_model/tensorrt_fp16.engine"


# ===============================================================
# 카메라 동영상 읽어오기
Camera = camera.Video_Setting()
capture = Camera.video_read()

flag = 2
# detection = cam.Detect()
# detection.main(capture)

# 차선 인식 클래스
line_detector = LineDetector()

# CUDA 드라이버 초기화
cuda.init()
# GPU 0의 CUDA Context 생성
cuda_ctx = cuda.Device(0).make_context()

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
            print(topic, " : ", message)

            if "mode1" in topic:
                if "start" in message:
                    flag = 1
                elif "end" in message:
                    flag = 2
            elif "mode2" in topic:
                flag = 3
            else:
                pass

            flag = 1
            # ------------------ 자율 주행 모드 ON -----------------
            if flag == 1:
                print("자율 주행 ON")
                #rover.forward()

                # 자율 주행 카메라 영상 처리
                # ---- 1. 차선 인식 ----
                # 차선 인식 화면
                frame = line_detector.line_camera(frame)

                # 서보 모터 각도 조절
                rover.set_angle(line_detector.angle)

                # ---- 2. 객체 인식 ----



            #  ------------------ 자율 주행 모드 OFF -----------------
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

        campub.sendBase64(frame)

except KeyboardInterrupt:
    pass

finally:
    cuda_ctx.pop()
    del cuda_ctx