import sys
import cv2
import threading
import time

#%% 프로젝트 폴더를 sys.path에 추가(Jetson Nano에서 직접 실행할 때 필요)
project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from utils.trt_ssd_object_detect_v2 import TrtThread, BBoxVisualization
from utils.object_label_map import CLASSES_DICT
from mqtt.Camerapublisher import ImageMqttPusblisher
import threading

class Detect:
    def __init__(self):
        self.angle = 0
        self.campub = ImageMqttPusblisher("192.168.3.223", pubTopic="/camerapub/rover1")
        self.campub.connect()

    # 감지 결과 활용(처리)
    def handleDetectedObject(self, trtThread, condition):
        # 초당 프레임 수
        fps = 0.0

        # 시작 시간
        tic = time.time()

        # 바운딩 박스 시각화 객체
        vis = BBoxVisualization(CLASSES_DICT)

        # TrtThread가 실행 중일때 반복 실행
        while trtThread.running:
            print("thread running")
            with condition:
                # 감지 결과가 있을 때까지 대기
                condition.wait()
                # 감지 결과 얻기
                img, boxes, confs, clss, self.angle, lane_img = trtThread.getDetectResult()

            # 감지 결과 출력
            img = vis.drawBboxes(img, boxes, confs, clss)

            img = cv2.addWeighted(img, 0.5, lane_img, 0.5, 0)

            # 초당 프레임 수 드로잉
            # img = vis.drawFps(img, fps)

            self.campub.sendBase64(img)

            # 초당 프레임 수 계산
            toc = time.time()
            curr_fps = 1.0 / (toc-tic)
            fps = curr_fps if fps==0.0 else (fps*0.95 + curr_fps*0.05)
            tic = toc


    #%% 메인 함수
    def main(self, videoCapture):
        # 엔지 파일 경로
        from utils import camera
        enginePath = project_path + "/models/ssd_mobilenet_v2_object_model/tensorrt_fp16.engine"

        # 감지 결과(생산)와 처리(소비)를 동기화를 위한 Condition 얻기
        condition = threading.Condition()
        # TrtThread 객체 생성
        trtThread = TrtThread(enginePath, TrtThread.INPUT_TYPE_VIDEO, videoCapture, 0.6, condition)
        # 감지 시작
        trtThread.start()

        # 감지 결과 처리(활용)
        self.handleDetectedObject(trtThread, condition)

        # 감지 중지
        trtThread.stop()

        # VideoCapture 중지
        videoCapture.release()

if __name__ == '__main__':

    try:
        import utils.camera as camera
        from mqtt.subscriber import MqttSubscriber
        # from AI_Rover import AI_Rover

        Camera = camera.Video_Setting()
        capture = Camera.video_read()

        detection = Detect()
        detection.main(capture)

        mqttSub = MqttSubscriber("192.168.3.223", topic="/order/rover1/#")
        mqttSub.start()

    except KeyboardInterrupt:
        mqttSub.stop()
    # rover = AI_Rover()