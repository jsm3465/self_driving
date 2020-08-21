import time
import threading
import sys

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from sensor.Pcf8591 import Pcf8591

class Distance:
    def __init__(self, pcf8591, ain=0):
        self.__pcf8591 = pcf8591
        self.__ain = ain
        self.dist = 0
        # super().__init__(daemon=True)
        # super().start()

    def read(self):
        value = self.__pcf8591.read(self.__ain)
        value = (value / 1023) * 5000
        self.dist = (27.61 / (value - 0.1696)) * 1000 / 4
        return self.dist

    # def run(self):
    #     while True:
    #         value = (self.read() / 1023) * 5000
    #         self.dist = (27.61 / (value - 0.1696)) * 1000 / 4
    #         time.sleep(0.5)


import math
if __name__ == '__main__':
    try:
        pcf8591 = Pcf8591(0x48)
        sensor = Distance(pcf8591, 0)
        while True:
            dist = sensor.read()
            print("거리 : ", dist, "cm")
            time.sleep(0.5)
    except KeyboardInterrupt:
        print()
    finally:
        print("Program exit")