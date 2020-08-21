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
from sensor.distance import Distance
from sensor.Pcf8591 import Pcf8591

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
        self.frame = None

        # sensor
        self.pcf8591 = Pcf8591(0x48)
        self.distance = Distance(self.pcf8591, 0)

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
            # print("right:" + self.__handle_angle)

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
            # print("left : " + self.__handle_angle)

    def backward(self):
        # if self.__dcMotor_speed < 1.0:
        #     self.__dcMotor_speed += 0.01
        # self.__motor_control.throttle_gain = self.__dcMotor_speed
        # print("forward")
        # self.__motor_control.throttle = 0
        self.__direction = "backward"
        self.__motor_control.throttle_gain = 0.6
        self.__motor_control.throttle = 1
        self.__dcMotor_speed = self.__motor_control.throttle_gain * 100

    def forward(self):
        # if self.__dcMotor_speed < 1.0:
        #     self.__dcMotor_speed += 0.01
        # self.__motor_control.throttle_gain = self.__dcMotor_speed
        # print("backward")
        # self.__motor_control.throttle = 0
        self.__direction = "forward"
        self.__motor_control.throttle_gain = 0.6
        self.__motor_control.throttle = -1
        self.__dcMotor_speed = self.__motor_control.throttle_gain * 100

    def stop(self):
        # print("stop")
        self.setspeed(30)
        self.__direction = "stop"
        self.__dcMotor_speed = 0
        self.__motor_control.throttle_gain = self.__dcMotor_speed
        self.__motor_control.throttle = self.__dcMotor_speed

    def setspeed(self, speed):

        if speed < 0:
            throttle = 1
        else:
            throttle = -1
        self.__motor_control.throttle_gain = (abs(speed) / 100)
        self.__motor_control.throttle = throttle
        self.__dcMotor_speed = abs(speed)
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
        # message["buzzer"] = self.buzzer.state # on, off
        message["dcmotor_speed"] = str(int(self.__dcMotor_speed))
        message["dcmotor_dir"] = self.__direction # forward, backward
        message["distance"] = str(self.distance.read())
        # message["photo"] = str(self.photo.photolevel) # 계속 변화하는 조도값
        # message["led"] = self.led.state # red, green, blue
        message["angle"] = str(self.__angle)  # 앞바퀴 서보
        # message["temperature"] = str(self.thermistor.cur_temp) # 계속 변화하는 온도 ( 지금은 1초 주기인데 늘려도 괜찮을듯)
        message["battery"] = str(self.get_voltage_percentage())
        message["mode"] = self.mode
        message["fps"] = str(self.fps)

        message = json.dumps(message)
        return message
