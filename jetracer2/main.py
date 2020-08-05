import sys

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from mqtt.subscriber import MqttSubscriber
from mqtt.Camerapublisher import ImageMqttPusblisher
from mqtt.publisher import MqttPublisher
from AI_Rover import AI_Rover
from utils import PID, camera
import linedetect.line_detect as line

from datetime import datetime
from collections import deque

mqttSub = MqttSubscriber("192.168.3.223", topic="/Order/rover1/*")
mqttSub.start()

campub = ImageMqttPusblisher("192.168.3.223", pubTopic="/camerapub/rover1")
campub.connect()

rover = AI_Rover()

sensorpub = MqttPublisher(rover, "192.168.3.223", topic="/sensor/rover1")
sensorpub.start()

Camera = camera.Video_Setting()
capture = Camera.video_read()

road_half_width_list = deque(maxlen=10)
road_half_width_list.append(165)

pid_controller = PID.PIDController(round(datetime.utcnow().timestamp() * 1000))
pid_controller.set_gain(0.63, -0.001, 0.23)

while True:
    retval, frame = capture.read()
    if not retval:
        print("video capture fail")
        break

    topic = mqttSub.topic
    message = mqttSub.message
    if "mode1" in topic:
        line_retval, L_lines, R_lines = line.line_detect(frame)

        # =========================선을 찾지 못했다면, 다음 프레임으로 continue=========================
        if line_retval == False:
            pass
        else:
            # ==========================선 찾아서 offset으로 돌려야할 각도 계산====================
            angle = line.offset_detect(frame, L_lines, R_lines, road_half_width_list)
            angle = pid_controller.equation(angle)

            # 핸들 제어
            rover.set_angle(angle)

    elif "mode2" in topic:
        if "direction" in topic:
            if message == "forward":
                rover.forward()
            elif message == "backward":
                rover.backward()
            elif message == "stop":
                rover.stop()
            elif message == "left":
                rover.handle_left()
            elif message == "right":
                rover.handle_right()
            elif message == "refront":
                rover.handle_refront()
    else:
        pass

    campub.sendBase64(frame)
