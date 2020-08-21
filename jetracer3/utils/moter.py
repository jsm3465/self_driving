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
    import time
    project_path = "/home/jetson/MyWorkspace/jetracer"
    sys.path.append(project_path)

    moter = Moter()
    # moter.DCmoter(1)
    moter.servo(30)
    time.sleep(2)
    moter.servo(-30)
    time.sleep(2)
    moter.servo(0)
    print("end")
