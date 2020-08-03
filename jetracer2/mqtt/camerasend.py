import sys
import cv2

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from camera import Video_Setting
from mqtt.Camerapublisher import ImageMqttPusblisher
from lane_detect_v2 import LaneDetection

camera = Video_Setting()
video = camera.video_read()
lanedetect = LaneDetection()

imageMqttPusblisher = ImageMqttPusblisher("192.168.3.250", 1883, "/camerapub")
imageMqttPusblisher.connect()
while True:
    if video.isOpened():
        retval, frame = video.read()
        if not retval:
            # print("video capture fail")
            break
        lane_img = lanedetect.run(frame)
        imageMqttPusblisher.sendBase64(lane_img)
        # print("send")
    else:
        break

imageMqttPusblisher.disconnect()
video.release()