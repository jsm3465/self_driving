import smbus

class Pcf8591:
    def __init__(self, addr):
        # Jetson Nano Board의 I2C Bus 번호 설정
        # I2CBUS 1번을 사용한다는 뜻,
        # I2CBUS 0번은 우리가 사용못함(보드 안에서 사용하는 I2CBUS)
        self.__bus = smbus.SMBus(1)
        # PCF8591의 I2C 장치 번호
        self.__addr = addr

    # channel : AIN0 ~ AIN3
    def read(self, channel):
        try:
            if channel == 0:
                # 48번 장치(PCF8591)에게 40번(AIN0)에 들어오는 값을 받겠다고 말해주는 것
                self.__bus.write_byte(self.__addr, 0x40)
            elif channel == 1:
                self.__bus.write_byte(self.__addr, 0x41)
            elif channel == 2:
                self.__bus.write_byte(self.__addr, 0x42)
            elif channel == 3:
                self.__bus.write_byte(self.__addr, 0x43)

            # 데이터를 받기위해서 장치가 알았다고 얘기하는 것
            self.__bus.read_byte(self.__addr);
            # 48번 장치(Pcf8591)에서 들어오는 값
            value = self.__bus.read_byte(self.__addr);
        except Exception as e:
            print(e)
            value = -1

        return value

    # value : AOUT으로 출력되는 값
    def write(self, value):
        try:
            # value 값이 정수여야 함
            value = int(value)
            # data를 보내는 것, Pcf8591은 마스터에서 데이터가 넘어오면
            # 무조건 AOUT으로 넘겨주기 때문에 0x40을 적든 다른걸 적든 마음대로 해도 됨
            self.__bus.write_byte_data(self.__addr, 0x40, value)
        except Exception as e:
            print(e)

if __name__ == '__main__':
    pcf8591 = Pcf8591(0x48)
    while True:
        value = pcf8591.read(0)
        print("value: {}".format(value))
        light = value * (255 - 0) / 255 + 0
        pcf8591.write(light)
