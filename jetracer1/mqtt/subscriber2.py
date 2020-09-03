import paho.mqtt.client as mqtt
import threading
from utils.sign_label_map2 import CLASSES_DICT


class MqttSubscriber:
    def __init__(self, brokerip=None, brokerport=1883, topic=None):
        self.__brokerip = brokerip
        self.__brokerport = brokerport
        self.__topic = topic
        self.__client = mqtt.Client()
        self.__client.on_connect = self.__on_connect
        self.__client.on_disconnect = self.__on_disconnect
        self.__client.on_message = self.__on_message
        self.message = None
        self.receive = True
        self.start_loc = None
        self.end_loc = None

    def __on_connect(self, client, userdata, flags, rc):
        print("** subscriber connection **")
        self.__client.subscribe(self.__topic, qos=0)

    def __on_disconnect(self, client, userdata, rc):
        print("** disconnection **")

    def __on_message(self, client, userdata, message):
        # print(message.topic)
        msg = str(message.payload, encoding="UTF-8")
        if "receive" in message.topic:
            self.receive = True
        elif "start" in message.topic:
            for i, class_name in CLASSES_DICT.items():
                if msg == class_name:
                    self.start_loc = i
                    print(self.start_loc)
            self.message = message

        elif "end" in message.topic:
            for i, class_name in CLASSES_DICT.items():
                if msg == class_name:
                    self.end_loc = i
                    print(self.end_loc)
            self.message = message

        else:
            self.message = message

    def start(self):
        thread = threading.Thread(target=self.__subscribe)
        thread.start()

    def __subscribe(self):
        self.__client.connect(self.__brokerip, self.__brokerport)
        self.__client.loop_forever()

    def stop(self):
        self.__client.unsubscribe(self.__topic)
        self.__client.disconnect()


if __name__ == '__main__':
    mqttSubscriber = MqttSubscriber("192.168.3.179", topic="/sensor")
    mqttSubscriber.start()
