import sys
project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from mqtt.subscriber import MqttSubscriber
from mqtt.Camerapublisher import ImageMqttPusblisher
from mqtt.publisher import MqttPublisher
from mqtt.objectpublisher import ObjectPublisher

from AI_Rover import AI_Rover

from utils import camera
from linedetect.line_detect import LineDetector
import pycuda.driver as cuda

from utils import trt_ssd_object_detect as trt
from utils.object_label_map import CLASSES_DICT
import time
import cv2

# ======================= MQTT ================================
rover = AI_Rover()

mqttSub = MqttSubscriber("192.168.3.250", topic="/rover1/order/#")
mqttSub.start()

campub = ImageMqttPusblisher(rover, mqttSub, "192.168.3.250", pubTopic="/rover1/camerapub")
campub.connect()

sensorpub = MqttPublisher(rover, "192.168.3.250", topic="/rover1/sensor")
sensorpub.start()

objectpub = ObjectPublisher("192.168.3.250", topic="/rover1/object")
objectpub.start()

# ==================== object detection ========================
conf_th = 0.6
fps = 0.0
enginePath = project_path + "/models/ssd_mobilenet_v2_model_10_47396/tensorrt_fp16.engine"

# ===============================================================
# 카메라 동영상 읽어오기 하세요
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
stopflag = 0
# 시작 시간
tic = time.time()

switchlane = False
switchcnt = 0
try:
    while True:
        # 카메라 영상 캡처
        retval, frame = capture.read()
        if not retval:
            print("video capture fail")
            break

        if switchlane:
            # print("cone!!!")
            # line_detector.line_detect(frame)
            # rover.forward()
            # if line_detector.presentroad == 1:
            #     rover.set_angle(-15)
            #     switchcnt += 1
            #     if switchcnt > 20:
            #         if line_detector.rightCorner:
            #             switchlane = False
            # elif line_detector.presentroad == 2:
            #     rover.set_angle(15)
            #     switchcnt += 1
            #     if switchcnt > 20:
            #         if line_detector.leftCorner:
            #             switchlane = False
            switchlane = False

        else:
            # 웹에서 주행 모드 커맨드 받아옴
            # flag - (1: 자율 주행 모드, 2: 자율 주행 모드 정지, 3: 조종 모드)
            if mqttSub.message != None:
                topic = mqttSub.message.topic
                message = str(mqttSub.message.payload, encoding="UTF-8")
                # print(topic, " : ", message)

                if "mode1" in topic:
                    rover.mode = "AI"
                    if "start" in message:
                        flag = 1
                    elif "end" in message:
                        flag = 2
                elif "mode2" in topic:
                    rover.mode = "manual"
                    flag = 3
                else:
                    pass

                # ------------------ 자율 주행 모드 ON -----------------
                if flag == 1:
                    stopflag = 0
                    # print("자율 주행 ON")
                    # dist = rover.distance.read()
                    #
                    # if dist < 35:
                    #     rover.setspeed(40)
                    #     stopflag = 1
                    # else:
                    #     stopflag = 0

                    # 자율 주행 카메라 영상 처리
                    # ---- 1. 차선 인식 ----
                    # 차선 인식 화면
                    line = line_detector.line_camera(frame)

                    # 서보 모터 각도 조절
                    rover.set_angle(line_detector.angle)

                    # ---- 2. 객체 인식 ----
                    boxes, confs, clss = trt_ssd.detect(frame, conf_th)

                    # 감지 결과 출력
                    # obj = vis.drawBboxes(frame, boxes, confs, clss)

                    # frame = cv2.addWeighted(line, 0.5, frame, 0.5, 0)

                    if len(clss) > 0:
                        objectpub.publish(clss, boxes)
                        # 빨간불
                        if 1 in clss:
                            index = clss.index(1)
                            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
                            # if size > 350:
                            #     stopflag = 1
                            # print(size)

                        # 노란불
                        if 3 in clss:
                            index = clss.index(3)
                            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
                            # if size > 350:
                            #     stopflag = 1
                            # print(size)

                        # 횡단보도
                        if 4 in clss:
                            index = clss.index(4)
                            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
                            # line_detector.crosswalk = True
                            # stopflag = 1
                            # print(size)

                        # stop
                        if 7 in clss:
                            index = clss.index(7)
                            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
                            # if size > 3000:
                            #     stopflag = 1
                            # print(size)

                        # cone
                        if 11 in clss:
                            index = clss.index(11)
                            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
                            # if size > 2000:
                            #     stopflag = 1
                            # switchcnt = 0
                            # switchlane = True
                            # print(size)

                        # bump
                        if 12 in clss:
                            index = clss.index(12)
                            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
                            # line_detector.crosswalk = True
                            # stopflag = 1
                            # print(size)

                    if stopflag == 1:
                        if line_detector.crosswalk:
                            rover.setspeed(45)
                        else:
                            rover.stop()
                    else:
                        rover.forward()

                # ------------------ 자율 주행 모드 OFF -----------------
                elif flag == 2:
                    rover.stop()

                #  ------------------ 조작 모드 -----------------
                elif flag == 3:
                    # print("mode2 실행")
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
                        elif message == "maxspeed":
                            rover.setspeed(-70)
                        elif message == "changestart":
                            switchcnt = 0
                            switchlane = True
                else:
                    mqttSub.receive = True

        # 초당 프레임 수 드로잉
        # img = vis.drawFps(frame, fps)

        # 초당 프레임 수 계산
        toc = time.time()
        curr_fps = 1.0 / (toc - tic)
        fps = curr_fps if fps == 0.0 else (fps * 0.95 + curr_fps * 0.05)
        rover.fps = fps

        if mqttSub.receive:
            campub.sendBase64(frame)
            tic = toc
            mqttSub.receive = False


except KeyboardInterrupt:
    pass

finally:
    rover.stop()
    rover.set_angle(0)
    cuda_ctx.pop()
    del cuda_ctx