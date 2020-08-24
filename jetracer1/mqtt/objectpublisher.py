import paho.mqtt.client as mqtt
import threading
from utils.sign_label_map2 import CLASSES_DICT
import json

class ObjectPublisher:
    def __init__(self, brokerIp=None, brokerPort=1883, topic=None):
        self.__brokerIp = brokerIp
        self.__brokerPort = brokerPort
        self.__topic = topic
        self.client = mqtt.Client()
        self.client.on_connect = self.__on_connect
        self.client.on_disconnect = self.__on_disconnect

    def __on_connect(self):
        print("** publisher connection **")

    def __on_disconnect(self):
        print("** disconnection **")

    def publish(self, clss, boxes):
        message = {}

        for i, object in enumerate(clss):
            message[CLASSES_DICT[object]] = list(boxes[i])

        message = json.dumps(message)

        self.client.publish(self.__topic, message, retain=False)

    def start(self):
        self.client.connect(self.__brokerIp, self.__brokerPort)

    def stop(self):
        self.client.disconnect()
