import time
import threading
import json
from jetracer.nvidia_racecar import NvidiaRacecar
import numpy as np

import sys

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

import utils.ipaddress as ip
import utils.power as pw
from utils.display import Oled
# from sensor.distance import Distance
# from sensor.Pcf8591 import Pcf8591

class AI_Rover:
    def __init__(self):
        self.__motor_control = NvidiaRacecar()

        # Oled 표시, 스레딩
        self.__oled = Oled()
        self.__oled_thread = threading.Thread(target=self.__oled_setting, daemon=True)
        self.__oled_thread.start()
        # =================motor values========================
        self.__handle_angle = 0
        self.__dcMotor_speed = 0
        self.__direction = None
        self.__angle = 0
        self.mode = "manual"
        self.fps = 0
        self.__stopflag = True

        self.currentLocation = None
        self.presentroad = None
        self.L_lines = []
        self.R_lines = []

        # sensor
        # self.pcf8591 = Pcf8591(0x48)
        # self.distance = Distance(self.pcf8591, 0)

    def __oled_setting(self):
        while True:
            self.__oled.set_text(ip.get_ip_address_wlan0() + "\n" + pw.get_power_status())
            time.sleep(2)

    def get_voltage_percentage(self):
        voltage_percentage = pw.get_voltage()
        return voltage_percentage

    # ==========================================================================
    def handle_right(self):
        if self.__handle_angle >= -1:
            self.__handle_angle -= 0.1
            self.__motor_control.steering = self.__handle_angle
            angle = int(self.__handle_angle * 30)
            if angle > 30:
                angle = 30
            if angle < -30:
                angle = -30
            self.__angle = angle

    def handle_left(self):
        if self.__handle_angle <= 1:
            self.__handle_angle += 0.1
            self.__motor_control.steering = self.__handle_angle
            angle = int(self.__handle_angle * 30)
            if angle > 30:
                angle = 30
            if angle < -30:
                angle = -30
            self.__angle = angle

    def backward(self, speed):
        self.__direction = "backward"
        self.__motor_control.throttle_gain = speed
        self.__motor_control.throttle = 1
        self.__dcMotor_speed = self.__motor_control.throttle_gain * 100

    def forward(self, speed):

        # 멈췄다가 출발할때 앞으로 가지못하는 것을 해결하기 위해 사용
        if self.__stopflag:
            self.__motor_control.throttle = 0
            self.__motor_control.throttle_gain = 0.9
            self.__motor_control.throttle = -1
            self.__stopflag = False

        self.__motor_control.throttle = 0
        self.__direction = "forward"
        self.__motor_control.throttle_gain = speed
        self.__motor_control.throttle = -1
        self.__dcMotor_speed = self.__motor_control.throttle_gain * 100

    def stop(self):
        self.__direction = "stop"
        self.__dcMotor_speed = 0
        self.__motor_control.throttle_gain = self.__dcMotor_speed
        self.__motor_control.throttle = self.__dcMotor_speed
        self.__stopflag = True

    def setspeed(self, speed):
        if speed < 0:
            self.backward(abs(speed))
        elif speed == 0:
            self.stop()
        else:
            self.forward(speed)

    # =========================================================================

    def set_angle(self, angle):
        if angle > 30:
            angle = 30
        if angle < -30:
            angle = -30

        self.__angle = int(angle)

        steering = angle / 30
        self.__motor_control.steering = steering

    def sensorMessage(self):
        message = {}
        message["dcmotor_speed"] = str(int(self.__dcMotor_speed))
        message["dcmotor_dir"] = self.__direction # forward, backward
        # message["distance"] = str(self.distance.read())
        message["angle"] = str(self.__angle)  # 앞바퀴 서보
        message["battery"] = str(self.get_voltage_percentage())
        message["mode"] = self.mode
        message["fps"] = str(self.fps)

        message = json.dumps(message)
        return message

    # def AEB(self):
    #     dist = self.distance.read()
    #     print("distance :", dist)
    #
    #     if dist < 35:
    #         self.stop()
    #         self.__stopflag = True
    #         return True
    #     else:
    #         return False

    def changeRoad(self, count, change_road_flag, speed):
        # 오른쪽 차선에 있을 때
        if self.presentroad == 2:
            if count < 16:
                # 핸들 왼쪽으로 꺾
                self.set_angle(16)
                self.forward(0.56)
                count += 1
                speed = 0

            else:
                print("yeah")
                if bool(len(self.L_lines) != 0) or bool(len(self.R_lines) != 0):
                    change_road_flag = False
                    self.presentroad = 1
                    count = 0
                    speed = 0.55

            return count, change_road_flag, speed

        # 왼쪽 차선에 있을 때
        else:
            if count < 16:
                # 핸들 오른쪽으로 꺾
                self.set_angle(-16)
                self.forward(0.56)
                count += 1
                speed = 0

            else:
                print("yeah")
                if bool(len(self.L_lines)) != 0 or bool(len(self.R_lines)) != 0:
                    change_road_flag = False
                    self.presentroad = 2
                    count = 0
                    speed = 0.55

            return count, change_road_flag, speed

