import cv2
import paho.mqtt.client as mqtt
import threading
import base64
import time


class ImageMqttPublisher:
    def __init__(self, brokerIp, brokerPort, pubTopic):
        self.brokerIp = brokerIp
        self.brokerPort = brokerPort
        self.pubTopic = pubTopic
        self.client = None

    def connect(self):
        thread = threading.Thread(target=self.__run, daemon=True)
        thread.start()

    def __run(self):
        self.client = mqtt.Client()
        self.client.on_connect = self.__on_connect
        self.client.on_disconnect = self.__on_disconnect
        self.client.connect(self.brokerIp, self.brokerPort)
        self.client.loop_forever()

    def __on_connect(self, client, userdata, flags, rc):
        print('imageMqttClient mqtt broker connected')

    def __on_disconnect(self, client, userdata, rc):
        print('imageMqttClient mqtt broker disconnected')

    def disconnect(self):
        self.client.disconnect()

    def sendBase64(self, frame):
        if self.client is None:
            return
        if not self.client.is_connected():
            return
        retval, bytes = cv2.imencode(".jpg", frame)
        if not retval:
            print('image encoding fail')
            return
        b64_bytes = base64.b64encode(bytes)
        self.client.publish(self.pubTopic, b64_bytes)


if __name__ == "__main__":
    videoCapture = cv2.VideoCapture(0)
    videoCapture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    videoCapture.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

    imageMqttPublisher = ImageMqttPublisher('192.168.3.131', 1883, "/camerapub")
    imageMqttPublisher.connect()

    while True:
        if videoCapture.isOpened():
            retval, frame = videoCapture.read()
            if not retval:
                print('video capture fail')
                break
            imageMqttPublisher.sendBase64(frame)
            time.sleep(0.1)
        else:
            break

    imageMqttPublisher.disconnect()
    videoCapture.release()
