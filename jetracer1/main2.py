import sys
project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from mqtt.subscriber2 import MqttSubscriber
from mqtt.Camerapublisher2 import ImageMqttPusblisher
from mqtt.publisher import MqttPublisher
from mqtt.objectpublisher import ObjectPublisher

from AI_Rover2 import AI_Rover

from utils import camera
from linedetect.line_detect2 import LineDetector
import pycuda.driver as cuda

from utils import trt_ssd_object_detect as trt
from utils.sign_label_map2 import CLASSES_DICT
import time
import cv2

# ======================= MQTT ================================
rover = AI_Rover()

mqttSub = MqttSubscriber("192.168.3.250", topic="/rover1/order/#")
mqttSub.start()

campub = ImageMqttPusblisher("192.168.3.250", pubTopic="/rover1/camerapub")
campub.connect()

campub2 = ImageMqttPusblisher("192.168.3.242", pubTopic="/blackBox/rover1")
campub2.connect()

sensorpub = MqttPublisher(rover, "192.168.3.250", topic="/rover1/sensor")
sensorpub.start()

objectpub = ObjectPublisher("192.168.3.250", topic="/rover1/object")
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
line_detector = LineDetector(rover)

# CUDA 드라이버 초기화
cuda.init()
# GPU 0의 CUDA Context 생성
cuda_ctx = cuda.Device(0).make_context()

# 객체 인식 클래스
trt_ssd = trt.TrtSSD(enginePath)
vis = trt.BBoxVisualization(CLASSES_DICT)



# -------- 전역 변수 ---------
stopflag = 0
# 시작 시간
tic = time.time()

change_road_flag = False
change_count = 0

speed = 0.55

start = None
end = None

naviflag = 0
navicnt = 0

# ---------- 함수 ----------------

def setMode(topic, message):
    mode = 0

    if "mode1" in topic:
        rover.mode = "AI"
        if "start" in message:
            mode = 1
        elif "end" in message:
            mode = 2
    elif "mode2" in topic:
        rover.mode = "manual"
        mode = 3
    elif "mode3" in topic:
        global naviflag
        rover.mode = "navi"
        mode = 1
        naviflag = 0
    else:
        pass

    return mode


def obj_operations(clss, boxes, speed, change_road_flag, change_count):

    stopflag = 0

    # 객체 감지에 따른 주행 동작
    if len(clss) > 0:
        objectpub.publish(clss, boxes)

        # speed 100
        if 9 in clss:
            speed = 0.6

        # green
        if 2 in clss:
            speed = 0.55

        # 횡단보도
        if 4 in clss:
            speed = 0.49

        # 어린이 보호구역
        if 5 in clss:
            speed = 0.49

        # 급커브
        if 6 in clss:
            speed = 0.49

        # speed 60
        if 8 in clss:
            speed = 0.49

        # cone
        if 11 in clss:
            index = clss.index(11)
            size = (boxes[index][2] - boxes[index][0]) * (boxes[index][3] - boxes[index][1])
            if (boxes[index][0] > 100) and (boxes[index][2] < 220):
                if size > 900:
                    change_count = 0
                    change_road_flag = True
                    stopflag = 1
                    speed = 0

        # bump
        if 12 in clss:
            speed = 0.49

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

    if (rover.mode == "navi") and (mqttSub.start_loc is not None):
        global navicnt
        global naviflag

        if mqttSub.start_loc in clss:
            objectpub.client.publish("/rover3/navi", "drive start")
            navicnt += 1

            if navicnt < 10:
                stopflag = 1
                speed = 0
            elif navicnt < 20:
                speed = -0.3
            else:
                naviflag = 0
                speed = 0.55
        elif mqttSub.end_loc in clss:
            objectpub.client.publish("/rover3/navi", "drive end")
            navicnt += 1

            if navicnt < 40:
                stopflag = 1
                speed = 0
            elif navicnt < 50:
                speed = -0.3
            else:
                mqttSub.start_loc = None
                mqttSub.end_loc = None
                navicnt = 0
                naviflag = 0
        else:
            if naviflag == 0:
                objectpub.client.publish("/rover1/navi", "driving")
                naviflag = 1

    if stopflag == 1:
        rover.stop()


    return speed, change_road_flag, change_count



# -------------- main ----------------
prespeed = None
# CTRL + C 를 누르면 CUDA CONTEXT를 없애주기 위해서 try except 사용
# 없애주지 않으면 다음에 카메라를 못킴..
try:
    while True:
        # 카메라 영상 캡처
        retval, frame = capture.read()
        if not retval:
            print("video capture fail")
            break

        # ---- 객체 인식 ----
        boxes, confs, clss = trt_ssd.detect(frame, conf_th)

        # ---- 감지 결과 출력 ----
        obj = vis.drawBboxes(frame, boxes, confs, clss)

        # 웹에서 주행 모드 커맨드 받아와야지 움직이기 시작함
        if mqttSub.message != None:
            topic = mqttSub.message.topic
            message = str(mqttSub.message.payload, encoding="UTF-8")

            # 받은 토픽에 따라 모드 선택 (1: 자율 주행 모드, 2: 자율 주행 모드 정지, 3: 조종 모드)
            mode = setMode(topic, message)

            # ------------------ 자율 주행 모드 ON -----------------
            if mode == 1:
                # 자율 주행 카메라 영상 처리
                # ---- 1. 차선 인식 ----
                # 차선 인식 화면
                line = line_detector.line_camera(frame)


                if not change_road_flag:

                    # 서보 모터 각도 조절
                    rover.set_angle(line_detector.angle)

                    # object detect화면과 line detct 화면 합치기
                    frame = cv2.addWeighted(line, 0.5, obj, 0.5, 0)

                    # 객체 감지 행동
                    speed, change_road_flag, change_count = obj_operations(clss, boxes, speed, change_road_flag, change_count)

                    # 거리센서값이 가까우면 멈춤 rover.AEB는 멈춰야할때 True, 아니면 False를 반환
                    if rover.AEB():
                        speed = 0

                    # speed가 바뀔때만 setspeed 실행
                    if speed != prespeed:
                        rover.setspeed(speed)
                        prespeed = speed
                        print("rover speed : ", speed)

                # 차선 변경 시 동작
                else:
                    change_count, change_road_flag = rover.changeRoad(change_count)



            # ------------------ 자율 주행 모드 OFF -----------------
            elif mode == 2:
                rover.stop()

            #  ------------------ 조작 모드 -----------------
            elif mode == 3:
                if "direction" in topic:
                    if message == "forward":
                        rover.forward(0.55)
                    elif message == "backward":
                        rover.backward(0.55)
                    elif message == "stop":
                        rover.stop()
                    elif message == "left":
                        rover.handle_left()
                    elif message == "right":
                        rover.handle_right()
                    elif message == "maxspeed":
                        rover.setspeed(0.70)
                    elif message == "changestart":
                        change_count = 0
                        change_road_flag = True
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
            campub2.sendBase64(img)

except KeyboardInterrupt:
    pass

finally:
    rover.stop()
    rover.set_angle(0)
    cuda_ctx.pop()
    del cuda_ctx

