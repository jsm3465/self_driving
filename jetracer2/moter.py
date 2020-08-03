from jetracer.nvidia_racecar import NvidiaRacecar

class Moter:
    def __init__(self):
        self.car = NvidiaRacecar()
        self.car.throttle_gain = 0.6
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
    import time
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

    from lane_detect_v2 import LaneDetection
    import camera
    import cv2
    import math

    camera = camera.Video_Setting()
    capture = camera.video_read()
    moter = Moter()

    moter.DCmoter(0)
    # moter.stop()
    while True:
        ret, img = capture.read()

        lanedetect = LaneDetection()
        lane_img = lanedetect.run(img)
        angle = (math.atan(lanedetect.gradient) / math.pi ) * 180 * 10
        angle = angle/6

        if angle < 0:
            angle = (angle + 144) * 2.5
        elif angle > 0:
            angle = (angle - 144) * 2.5
        else:
            angle = 0

        print(angle)

        # if 100 <= lanedetect.offcenter < 147:
        #     angle = 0
        # elif 60 <= lanedetect.offcenter < 100:
        #     angle = 10
        # elif 35 < lanedetect.offcenter <= 60:
        #     angle = 20
        # elif lanedetect.offcenter <= 0:
        #     angle = 30
        # else:
        #     angle = -20

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


