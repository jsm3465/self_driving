import paho.mqtt.client as mqtt
import threading


class MqttClient:
    def __init__(self, brokerip=None, brokerport=1883, subtopic=None, pubtopic=None):
        self.__brokerip = brokerip
        self.__brokerport = brokerport
        self.subtopic = subtopic
        self.pubtopic = pubtopic
        self.client = mqtt.Client()
        self.client.on_connect = self.__on_connect
        self.client.on_disconnect = self.__on_disconnect
        self.client.on_message = self.__on_message

    def __on_connect(self, client, userdata, flags, rc):
        print("** connection **")
        self.__client.subscribe(self.subtopic, qos=0)

    def __on_disconnect(self, client, userdata, rc):
        print("** disconnection **")

    def on_message(self, client, userdata, message):
        msg = str(message.payload, encoding="UTF-8")
        print("구독 내용: {}, 토픽: {}, Qos: {}".format(
            str(message.payload, encoding="UTF-8"),
            message.topic,
            message.qos
        ))

        return message.topic, msg

    def __subscribe(self):
        self.__client.connect(self.__brokerip, self.__brokerport)
        self.__client.loop_forever()

    def __publish(self, message):
        self.__client.connect(self.__brokerIp, self.__brokerPort)
        self.__stop = False
        self.__client.loop_start()
        self.__client.publish(self.pubtopic, message, retain=False)
        # print("발행 내용:", self.__topic, message)
        self.__client.loop_stop()

    def start(self):
        thread = threading.Thread(target=self.__subscribe)
        thread.start()

    def stop(self):
        self.__client.unsubscribe(self.subtopic)
        self.__client.disconnect()


if __name__ == '__main__':
    mqttSubscriber = MqttSubscriber("192.168.3.179", topic="/sensor")
    mqttSubscriber.start()
