import sys

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)


class Distance:
    def __init__(self, pcf8591, ain=0):
        self.__pcf8591 = pcf8591
        self.__ain = ain
        self.dist = 0

    def read(self):
        value = self.__pcf8591.read(self.__ain)
        value = (value / 1023) * 5000
        self.dist = (27.61 / (value - 0.1696)) * 1000 / 4
        return self.dist
