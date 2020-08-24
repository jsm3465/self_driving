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
from utils.sign_label_map2 import CLASSES_DICT
import time
import cv2

# ======================= MQTT ================================
rover = AI_Rover()

mqttSub = MqttSubscriber("192.168.3.250", topic="/rover2/order/#")
mqttSub.start()

campub = ImageMqttPusblisher("192.168.3.250", pubTopic="/rover2/camerapub")
campub.connect()

campub2 = ImageMqttPusblisher("192.168.3.250", pubTopic="/blackBox/rover2")
campub2.connect()

sensorpub = MqttPublisher(rover, "192.168.3.250", topic="/rover2/sensor")
sensorpub.start()

objectpub = ObjectPublisher("192.168.3.250", topic="/rover2/object")
objectpub.start()

# ==================== object detection ========================
conf_th = 0.6
fps = 0.0
enginePath = project_path + "/models/ssd_mobilenet_v2_sign12/tensorrt_fp16.engine"

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

speed = 55

start = None
end = None

naviflag = 0
navicnt = 0

def obj_operations(clss, boxes, speed, switchcnt, switchlane):

    stopflag = 0
    # 객체 감지에 따른 주행 동작
    if len(clss) > 0:
        objectpub.publish(clss, boxes)

        # speed 100
        if 9 in clss:
            speed = 60

        # green
        if 2 in clss:
            speed = 55

        # 횡단보도
        if 4 in clss:
            speed = 49

        # 어린이 보호구역
        if 5 in clss:
            speed = 49

        # 급커브
        if 6 in clss:
            speed = 49

        # speed 60
        if 8 in clss:
            speed = 49

        # cone
        if 11 in clss:
            index = clss.index(11)
            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
            if (boxes[index][0] > 100) and (boxes[index][2] < 220):
                if size > 900:
                    stopflag = 1
                    switchcnt = 0
                    switchlane = True

        # bump
        if 12 in clss:
            speed = 49

        # 빨간불
        if 1 in clss:
            stopflag = 1
            speed = 0

        # 노란불
        if 3 in clss:
            stopflag = 1
            speed = 0

        # stop
        if 7 in clss:
            index = clss.index(7)
            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
            if size > 2000:
                speed = 0
                stopflag = 1

        if 30 in clss:
            stopflag = 1
            speed = 0

    # if stopflag == 1:
    #     rover.stop()

    return switchcnt, switchlane, speed


# ============== main =================

try:
    while True:
        # 카메라 영상 캡처
        retval, frame = capture.read()
        if not retval:
            print("video capture fail")
            break

        # ---- 객체 인식 ----
        boxes, confs, clss = trt_ssd.detect(frame, conf_th)

        # 감지 결과 출력
        obj = vis.drawBboxes(frame, boxes, confs, clss)


        # --- 콘 만났을 때 차선 변경 -----
        if switchlane:
            print("cone!!!")
            L_lines, R_lines = line_detector.line_detect(frame)

            if switchcnt < 50:
                switchcnt += 1
                rover.stop()
                rover.setspeed(-30)
            else:
                # 오른쪽 차선에 있을 때
                if line_detector.presentroad == 2:
                    if switchcnt < 66:
                        # 핸들 왼쪽으로 꺾
                        rover.set_angle(16)
                        rover.setspeed(56)
                        switchcnt += 1

                    else:
                        print("yeah")
                        if bool(len(L_lines) != 0) or bool(len(R_lines) != 0):
                            switchlane = False
                            line_detector.presentroad = 1
                            switchcnt = 0

                # 왼쪽 차선에 있을 때
                else:
                    if switchcnt < 66:
                        # 핸들 오른쪽으로 꺾
                        rover.set_angle(-16)
                        rover.setspeed(56)
                        switchcnt += 1

                    else:
                        print("yeah")
                        if bool(len(L_lines)) != 0 or bool(len(R_lines)) != 0:
                            switchlane = False
                            line_detector.presentroad = 2
                            switchcnt = 0



                # rover.setspeed(70)
                # if line_detector.presentroad == 1:
                #     # R_lines_detected = bool(len(R_lines) != 0)
                #     rover.set_angle(-12)
                #     switchcnt += 1
                #     if switchcnt > 90:
                #         if line_detector.rightCorner:
                #         # if R_lines_detected:
                #             rover.stop()
                #             switchlane = False
                #     elif switchcnt > 150:
                #         rover.stop()
                #         switchlane = False
                #
                # elif line_detector.presentroad == 2:
                #     # L_lines_detected = bool(len(L_lines) != 0)
                #     rover.set_angle(25)
                #     switchcnt += 1
                #     if switchcnt > 300:
                #         if line_detector.leftCorner:
                #         # if L_lines_detected:
                #             rover.stop()
                #             switchlane = False
                #     elif switchcnt > 400:
                #         rover.stop()
                #         switchlane = False

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
                elif "mode3" in topic:
                    rover.mode = "navi"
                    flag = 4
                else:
                    pass

                # ------------------ 자율 주행 모드 ON -----------------
                if flag == 1:
                    # 자율 주행 카메라 영상 처리
                    # ---- 1. 차선 인식 ----
                    # 차선 인식 화면
                    line = line_detector.line_camera(frame)

                    # 서보 모터 각도 조절
                    rover.set_angle(line_detector.angle)

                    frame = cv2.addWeighted(line, 0.5, obj, 0.5, 0)

                    # 객체 감지 행동
                    switchcnt, switchlane, speed = obj_operations(clss, boxes, speed, switchcnt, switchlane)
                    print(speed)

                    rover.setspeed(speed)

                    rover.AEB()

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
                            rover.setspeed(70)
                        elif message == "changestart":
                            switchcnt = 0
                            switchlane = True

                # ----------- navi ------------
                elif flag == 4:
                    if "start" in topic:
                        for i, class_name in CLASSES_DICT.items():
                            if message == class_name:
                                start = i

                    if "end" in topic:
                        for i, class_name in CLASSES_DICT.items():
                            if message == class_name:
                                end = i

                    # 차선 인식 화면
                    line = line_detector.line_camera(frame)
                    # 서보 모터 각도 조절
                    rover.set_angle(line_detector.angle)
                    frame = cv2.addWeighted(line, 0.5, obj, 0.5, 0)
                    switchcnt, switchlane, speed = obj_operations(clss, boxes, speed, switchcnt, switchlane)

                    # 출발지와 도착지 메시지 수신
                    if start is not None and end is not None:
                        if len(clss) > 0:
                            if start in clss:
                                objectpub.client.publish("/rover2/navi", "drive start")
                                navicnt += 1
                                if navicnt < 10:
                                    speed = -30
                                elif navicnt < 15:
                                    speed = 0
                                    print("A 멈춤")
                                elif navicnt < 40:
                                    speed = 55
                                    rover.forward()
                                    print("A 출발")
                            elif end in clss:
                                objectpub.client.publish("/rover2/navi", "drive end")
                                navicnt += 1
                                print("B도착@@@")
                                if navicnt < 50:
                                    speed = -30
                                elif navicnt < 55:
                                    speed = 0
                                else:
                                    start = None
                                    end = None
                                    navicnt = 0
                                    speed = 55

                        else:
                            objectpub.client.publish("/rover2/navi", "driving")


                    print(speed)
                    rover.setspeed(speed)
                else:
                    mqttSub.receive = True

        # 초당 프레임 수 드로잉
        img = vis.drawFps(frame, fps)

        # 초당 프레임 수 계산
        toc = time.time()
        curr_fps = 1.0 / (toc - tic)
        fps = curr_fps if fps == 0.0 else (fps * 0.95 + curr_fps * 0.05)
        rover.fps = fps

        if mqttSub.receive:
            campub.sendBase64(img)
            tic = toc
            mqttSub.receive = False
            # rover.frame = img
            # campub.send = True
            campub2.sendBase64(frame)

except KeyboardInterrupt:
    pass

finally:
    rover.stop()
    rover.set_angle(0)
    cuda_ctx.pop()
    del cuda_ctx