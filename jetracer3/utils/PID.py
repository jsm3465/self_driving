import time
from datetime import datetime
import queue

class PIDController():
    def __init__(self, last_time):
        self.__p_gain = 0
        self.__i_gain = 0
        self.__d_gain = 0
        self.__cur_time = 0
        self.__last_time = last_time
        self.__error_theta = 0
        self.__error_sum = 0
        self.__pre_error_theta = 0
        self.__sum_queue = queue.Queue()

    def set_gain(self,p_gain, i_gain, d_gain):
        self.__p_gain = p_gain
        self.__i_gain = i_gain
        self.__d_gain = d_gain

    def get_dt(self):
        self.__cur_time = round(datetime.utcnow().timestamp() * 1000)  # ms 얻기
        dt = self.__cur_time - self.__last_time
        return dt

    def set_last_time(self):
        self.__last_time = round(datetime.utcnow().timestamp() * 1000)

    def set_error_sum(self, theta):
        if self.__sum_queue.qsize() < 10:
            self.__sum_queue.put(theta)
            self.__error_sum = self.__error_sum + theta
        else:
            get_theta = self.__sum_queue.get()
            self.__sum_queue.put(theta)
            self.__error_sum = self.__error_sum + theta - get_theta

    def set_pre_error_theta(self, theta):
        self.__pre_error_theta = theta

    def equation(self,input_theta):
        kp = self.__p_gain
        ki = self.__i_gain
        kd = self.__d_gain
        dt = self.get_dt()
        error_theta = input_theta
        error_sum = self.__error_sum

        self.set_error_sum(error_theta)

        p_value = kp * error_theta
        i_value = ki * error_sum
        d_value = kd * (error_theta - self.__pre_error_theta) / dt

        target_theta = p_value + i_value + d_value
        self.set_pre_error_theta(error_theta)
        self.set_last_time()

        return target_theta