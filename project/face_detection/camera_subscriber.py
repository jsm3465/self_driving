import paho.mqtt.client as mqtt
import threading
import face_detection.face_classifier as classifier
import base64
import cv2
import numpy as np
import face_detection.camera_publisher as camera_publisher


class MqttSubscriber:
    def __init__(self, brokerip=None, brokerport=1883, topic=None):
        self.__brokerip = brokerip
        self.__brokerport = brokerport
        self.__topic = topic
        self.__client = mqtt.Client()
        self.__client.on_connect = self.on_connect
        self.__client.on_disconnect = self.on_disconnect
        self.__client.on_message = self.on_message
        self.faceclassifier = classifier.FaceClassifier()
        self.camerapublisher = camera_publisher.ImageMqttPublisher('192.168.3.242', 1883, "/camerapub/faceID", "/temp")

    def on_connect(self, client, userdata, flags, rc):
        print('MQTT Client MQTT broker connected')
        self.__client.subscribe(self.__topic, qos=0)

    def on_disconnect(self, client, userdata, rc):
        print('MQTT Client MQTT broker disconnected')

    def on_message(self, client, userdata, message):
        while True:
            print(message)
            message = message.payload
            print(message)
            bytes = base64.b64decode(message)
            np_data = np.frombuffer(bytes, dtype=np.uint8)
            img = cv2.imdecode(np_data, cv2.IMREAD_COLOR)
            print("-------------------------------------")
            img = self.faceclassifier.classify(img)
            cv2.imshow("", img)
            # self.camerapublisher.sendBase64(img)
            # print("-----------------")
            cv2.waitKey(1)

    def start(self):
        thread = threading.Thread(target=self.__subscribe, )
        thread.start()

    def __subscribe(self):
        self.__client.connect(self.__brokerip, self.__brokerport)
        self.__client.loop_forever()

    def stop(self):
        self.__client.unsubscribe(self.__topic)
        self.__client.disconnect()


if __name__ == '__main__':
    mqttsubscriber = MqttSubscriber('192.168.3.242', topic='/camerapub')
    mqttsubscriber.start()
