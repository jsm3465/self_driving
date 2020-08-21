import sys

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

import cv2

from utils.camera import Video_Setting
from mqtt.Camerapublisher import ImageMqttPusblisher
from linedetect.lane_detect_v2 import LaneDetection
# import linedetect.line_detect as line
# from AI_Rover import AI_Rover
# import utils.PID as PID
# from datetime import datetime
# from collections import deque

camera = Video_Setting()
video = camera.video_read()

imageMqttPusblisher = ImageMqttPusblisher("192.168.3.223", 1883, "/camerapub")
imageMqttPusblisher.connect()

# rover = AI_Rover()
#
# pid_controller = PID.PIDController(round(datetime.utcnow().timestamp() * 1000))
# pid_controller.set_gain(0.63, -0.001, 0.23)
#
# road_half_width_list = deque(maxlen=10)
# road_half_width_list.append(165)

lanedetect = LaneDetection()

while True:
    if video.isOpened():
        retval, frame = video.read()
        if not retval:
            # print("video capture fail")
            break
        lane_img = lanedetect.run(frame)
        imageMqttPusblisher.sendBase64(lane_img)
        # print("send")
        # line_retval, L_lines, R_lines = line.line_detect(frame)
        #
        # # =========================선을 찾지 못했다면, 다음 프레임으로 continue=========================
        # if line_retval == False:
        #     imageMqttPusblisher.sendBase64(frame)
        # else:
        #     # ==========================선 찾아서 offset으로 돌려야할 각도 계산====================
        #     angle = line.offset_detect(frame, L_lines, R_lines, road_half_width_list)
        #     angle = pid_controller.equation(angle)
        #
        #     # 핸들 제어
        #     rover.set_angle(angle)
        #     imageMqttPusblisher.sendBase64(frame)


imageMqttPusblisher.disconnect()
video.release()