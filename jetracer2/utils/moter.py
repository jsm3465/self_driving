from jetracer.nvidia_racecar import NvidiaRacecar

class Moter:
    def __init__(self):
        self.car = NvidiaRacecar()
        self.car.throttle_gain = 0.55
        self.car.steering = 0.0

    # -가 오른쪽, +가 왼쪽
    def servo(self, angle):
        if angle > 30:
            angle = 30
        elif angle < -30:
            angle = -30

        angle = angle / 30
        self.car.steering = angle

    def DCmoter(self, speed):
        self.car.throttle = speed

    def stop(self):
        self.car.throttle = 0

if __name__ == '__main__':
    import sys
    project_path = "/home/jetson/MyWorkspace/jetracer"
    sys.path.append(project_path)

    moter = Moter()
    # moter.DCmoter(1)
    moter.servo(0)

    # angle = -1.0
    # while True:
    #     moter.servo(angle)
    #     time.sleep(0.5)
    #     angle += 0.2
    #     print(angle)
    #     if angle >1.0:
    #         angle = -1.0

    from linedetect.lane_detect_v2 import LaneDetection
    import cv2
    import numpy as np
    from utils import PID, camera
    from datetime import datetime

    camera = camera.Video_Setting()
    capture = camera.video_read()

    # moter.DCmoter(-1)
    # moter.stop()

    while True:
        ret, img = capture.read()

        lanedetect = LaneDetection()
        lane_img = lanedetect.run(img)
        # angle = (math.atan(lanedetect.gradient) / math.pi) * 180 * 10
        # angle = angle/6
        # print(angle)
        #
        # if angle < 0:
        #     angle = (angle + 144) * 2.5
        # elif angle > 0:
        #     angle = (angle - 144) * 2.5
        # else:
        #     angle = 0

        pidcontroller = PID.PIDController(round(datetime.utcnow().timestamp() * 1000))
        pidcontroller.set_gain(0.63, 0, 0.24)

        angle = (np.arctan2(lanedetect.offheight*0.25, lanedetect.offcenter) * 180 / np.pi) - 23
        print(angle)

        angle = pidcontroller.equation(angle)
        moter.servo(angle)


        # if lanedetect.line == "Right":
        #     # print("Right", lanedetect.offcenter)
        #     if lanedetect.offcenter < 115:
        #         angle = (lanedetect.offcenter - 115) * -1
        #     elif 140 < lanedetect.offcenter:
        #         angle = lanedetect.offcenter - 140
        #     else:
        #         angle = 0
        # elif lanedetect.line == "Left":
        #     # print("Left", lanedetect.offcenter)
        #     if lanedetect.offcenter < 115:
        #         angle = lanedetect.offcenter - 115
        #     elif 140 < lanedetect.offcenter:
        #         angle = (lanedetect.offcenter - 140) * -1
        #     else:
        #         angle = 0
        # else:
        #     # print("Straight", lanedetect.offcenter)
        #     angle = 0

        if angle > 30:
            angle = 30
        elif angle < -30:
            angle = -30


        moter.servo(angle)

        cv2.imshow("lane_img", lane_img)

        if cv2.waitKey(1) == 27:
            moter.stop()
            moter.servo(0)
            break

    capture.release()
    cv2.destroyAllWindows()


