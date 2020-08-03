import cv2
import json
import base64
import threading

class AI_Rover(threading.Thread):
    def __init__(self):
        pass

    def run(self):
        pass

    def encode(self, frame):
        retval, bytes = cv2.imencode(".jpg", frame)
        if not retval:
            print("image encoding fail")
            return
        b64_bytes = base64.b64encode(bytes)
        return b64_bytes

    def sensorMessage(self):
        message = {}
        message["buzzer"] = self.buzzer.state  # on, off
        message = json.dumps(message)
        return message

    def cameraMessage(self):
        message = self.camera.message
        return message

    # if elif 조건에 없으면 아무동작 안하게 만들기
    def write(self, message, topic):

        # ============ 형욱 예나 ===============
        if topic.__contains__("/servo3"):
            if message.isdecimal():
                self.servo3.angle(int(message))

        if topic.__contains__("/buzzer"):
            if message == "on":
                self.buzzer.on()
            elif message == "off":
                self.buzzer.off()
            else:
                pass




if __name__ == '__main__':
    import mqtt.subscriber as sub
    import mqtt.publisher as pub

    AIrover = AI_Rover()

    camerapub = pub.MqttPublisher(AIrover, brokerip="192.168.3.60", brokerport=1883, topic="/camerapub")
    camerapub.start()

    publisher = pub.MqttPublisher(AIrover, brokerip="192.168.3.60", brokerport=1883, topic="/sensor")
    publisher.start()

    subscriber = sub.MqttSubscriber(AIrover, brokerip="192.168.3.60", brokerport=1883, topic="/command/#")
    subscriber.start()


