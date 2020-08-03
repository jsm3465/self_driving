import Adafruit_SSD1306
import PIL.Image
import PIL.ImageFont
import PIL.ImageDraw

class Oled(object):
    def __init__(self, *args, **kwargs):
        self.display = Adafruit_SSD1306.SSD1306_128_32(rst=None, i2c_bus=1, gpio=1)
        self.display.begin()
        self.display.clear()
        self.display.display()
        self.font = PIL.ImageFont.load_default()
        self.image = PIL.Image.new('1', (self.display.width, self.display.height))
        self.draw = PIL.ImageDraw.Draw(self.image)
        self.draw.rectangle((0, 0, self.image.width, self.image.height), outline=0, fill=0)

    # 디스플레이에 텍스트 입력
    def set_text(self, text):
        # 상자 드로잉
        # (leftopx, lefttopy, rightbottomx, rightbottomy), linewidth, fillcolor
        self.draw.rectangle((0, 0, self.image.width-1, self.image.height-1), outline=1, fill=0)
        # 줄바꿈 있으면 줄바꿈
        lines = text.split('\n')
        top = 2
        for line in lines:
            self.draw.text((4, top), line, font=self.font, fill=255)
            top += 10
        self.display.image(self.image)
        self.display.display()

if __name__ == "__main__":
    oled = Oled()
    oled.set_text("Hello\nOled")
