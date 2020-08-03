import camera
import cv2
from moter import Moter
from lane_detect_v1 import LaneDetection

# 카메라 켜기
camera = camera.Video_Setting()
capture = camera.video_read()

moter = Moter()
moter.DCmoter(-0.0)  # 전진
moter.servo(0.0)

while True:
    ret, img = capture.read()

    lanedetect = LaneDetection()
    lane_img = lanedetect.run(img)

    if lanedetect.direction == "Right Curve":
        moter.servo(-30.0)
    elif lanedetect.direction == "Left Curve":
        moter.servo(30.0)
    else:
        moter.servo(0.0)

    print(lanedetect.direction + " : " + str(lanedetect.diffx))


    cv2.imshow("lane_img", lane_img)

    if cv2.waitKey(1) == 27:
        moter.stop()
        break

capture.release()
cv2.destroyAllWindows()