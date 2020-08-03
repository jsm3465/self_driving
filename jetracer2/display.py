import threading
import Adafruit_SSD1306
import time
import PIL.Image
import PIL.ImageFont
import PIL.ImageDraw
from flask import Flask
import os


class DisplayServer(object):

    def __init__(self, *args, **kwargs):
        self.display = Adafruit_SSD1306.SSD1306_128_32(rst=None, i2c_bus=1, gpio=1)
        self.display.begin()
        self.display.clear()
        self.display.display()
        self.font = PIL.ImageFont.load_default()
        self.image = PIL.Image.new('1', (self.display.width, self.display.height))
        self.draw = PIL.ImageDraw.Draw(self.image)
        self.draw.rectangle((0, 0, self.image.width, self.image.height), outline=0, fill=0)
        self.stats_enabled = False
        self.stats_thread = None
        self.stats_interval = 1.0

    # 디스플레이 계속 바뀌게 만드는 것같은데 잘모르겠음
    def _run_display_stats(self):
        Charge = False
        while self.stats_enabled:

            self.draw.rectangle((0, 0, self.image.width, self.image.height), outline=0, fill=0)

            # set IP address
            top = -2

            self.draw.text((4, top), 'IP: print', font=self.font, fill=255)

            top = 6

            self.display.image(self.image)
            self.display.display()

    # 스레드 처리 하는 거같은데 잘모르겠음
    def enable_stats(self):
        # start stats display thread
        if not self.stats_enabled:
            self.stats_enabled = True
            self.stats_thread = threading.Thread(target=self._run_display_stats)
            self.stats_thread.start()

    # display 클리어
    def disable_stats(self):
        self.stats_enabled = False
        if self.stats_thread is not None:
            self.stats_thread.join()
        self.draw.rectangle((0, 0, self.image.width, self.image.height), outline=0, fill=0)
        self.display.image(self.image)
        self.display.display()


    # 디스플레이에 텍스트 입력
    def set_text(self, text):
        self.disable_stats()
        self.draw.rectangle((0, 0, self.image.width-1, self.image.height-1), outline=1, fill=0) # 상자그리는 거
        #                     좌상                   우하                       라인굵기


        # 줄바꿈 있으면 줄바꿈
        lines = text.split('\n')
        top = 2
        for line in lines:
            self.draw.text((4, top), line, font=self.font, fill=255)
            top += 10

        self.display.image(self.image)
        self.display.display()



if __name__ == '__main__':
    server = DisplayServer()
    server.set_text("print display\ntest")