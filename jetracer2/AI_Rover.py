import time
import threading
import json
from jetracer.nvidia_racecar import NvidiaRacecar

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

        # sensor
        self.pcf8591 = Pcf8591(0x48)
        self.distance = Distance(self.pcf8591, 0)

    def __oled_setting(self):
        while True:
            self.__oled.set_text(ip.get_ip_address_wlan0() + "\n" + pw.get_power_status())
            time.sleep(2)

    def get_voltage_percentage(self):
        voltage_percentage = round((pw.get_voltage() - 11.1) / 0.015)
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

    def handle_refront(self):
        while True:
            if -0.05 <= self.__handle_angle <= 0.05:
                self.__handle_angle = 0
                self.__motor_control.steering = self.__handle_angle
                break

            if self.__handle_angle < 0:
                self.__handle_angle += 0.05
            else:
                self.__handle_angle -= 0.05
            # print(self.__handle_angle)
            self.__motor_control.steering = self.__handle_angle

    def backward(self):
        # if self.__dcMotor_speed < 1.0:
        #     self.__dcMotor_speed += 0.01
        # self.__motor_control.throttle_gain = self.__dcMotor_speed
        # print("forward")
        # self.__motor_control.throttle = 0
        self.__direction = "backward"
        self.__motor_control.throttle_gain = 0.6
        self.__motor_control.throttle = 1
        self.__dcMotor_speed = 60

    def forward(self):
        # if self.__dcMotor_speed < 1.0:
        #     self.__dcMotor_speed += 0.01
        # self.__motor_control.throttle_gain = self.__dcMotor_speed
        # print("backward")
        # self.__motor_control.throttle = 0
        self.__direction = "froward"
        self.__motor_control.throttle_gain = 0.6
        self.__motor_control.throttle = -1
        self.__dcMotor_speed = 60

    def stop(self):
        # print("stop")
        self.__direction = "stop"
        self.__dcMotor_speed = 0
        self.__motor_control.throttle_gain = self.__dcMotor_speed
        self.__motor_control.throttle = self.__dcMotor_speed
    # =========================================================================

    def set_angle(self, angle):
        if angle > 30:
            angle = 30
        if angle < -30:
            angle = -30

        self.__angle = angle

        steering = angle / 30
        self.__motor_control.steering = steering

    def sensorMessage(self):
        message = {}
        # message["buzzer"] = self.buzzer.state # on, off
        message["dcmotor_speed"] = str(self.__dcMotor_speed)
        message["dcmotor_dir"] = self.__direction # forward, backward
        message["distance"] = str(self.distance.read())
        # message["photo"] = str(self.photo.photolevel) # 계속 변화하는 조도값
        # message["led"] = self.led.state # red, green, blue
        message["angle"] = str(self.__angle)  # 앞바퀴 서보
        # message["temperature"] = str(self.thermistor.cur_temp) # 계속 변화하는 온도 ( 지금은 1초 주기인데 늘려도 괜찮을듯)
        message["battery"] = str(self.get_voltage_percentage())

        message = json.dumps(message)
        return message


if __name__ == '__main__':
    import time

    rover = AI_Rover()
    # rover.forward()
    # time.sleep(5)
    rover.stop()
    #
    # import sys
    # project_path = "/home/jetson/MyWorkspace/jetracer"
    # sys.path.append(project_path)
    #
    # import cv2
    # from datetime import datetime
    # from collections import deque
    # import linedetect.line_detect as line
    # from utils import PID, camera
    #
    # road_half_width_list = deque(maxlen=10)
    # road_half_width_list.append(165)
    #
    # pid_controller = PID.PIDController(round(datetime.utcnow().timestamp() * 1000))
    # pid_controller.set_gain(0.63, -0.001, 0.23)
    #
    # Camera = camera.Video_Setting()
    # video = Camera.video_read()
    #
    # while video.isOpened():
    #     retval, frame = video.read()
    #     if not retval:
    #         print("video capture fail")
    #         break
    #
    #     line_retval, L_lines, R_lines = line.line_detect(frame)
    #
    #     # =========================선을 찾지 못했다면, 다음 프레임으로 continue=========================
    #     if line_retval == False:
    #         cv2.imshow("frame", frame)
    #         continue
    #     else:
    #         # ==========================선 찾아서 offset으로 돌려야할 각도 계산====================
    #         angle = line.offset_detect(frame, L_lines, R_lines, road_half_width_list)
    #         angle = pid_controller.equation(angle)
    #
    #         # 핸들 제어
    #         rover.set_angle(angle)
    #         cv2.imshow("frame", frame)
    #
    #     if cv2.waitKey(1) == 27:
    #         rover.stop()
    #         break
    #
    # video.release()
    # cv2.destroyAllWindows()
    # print("videoCapture is not opened")
    # rover.stop()
