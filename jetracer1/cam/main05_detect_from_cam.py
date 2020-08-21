import sys
import cv2
import threading
import time

#%% 프로젝트 폴더를 sys.path에 추가(Jetson Nano에서 직접 실행할 때 필요)
project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

from utils.trt_ssd_object_detect import TrtThread, BBoxVisualization
from utils.object_label_map import CLASSES_DICT

#%% 감지 결과 활용(처리)
def handleDetectedObject(trtThread, condition):
    # 전체 스크린 플래그 변수
    full_scrn = False

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
            img, boxes, confs, clss = trtThread.getDetectResult()

        # 감지 결과 출력
        img = vis.drawBboxes(img, boxes, confs, clss)

        # 초당 프레임 수 드로잉
        img = vis.drawFps(img, fps)

        # 이미지를 윈도우에 보여주기
        cv2.imshow("detect_from_video", img)

        # 초당 프레임 수 계산
        toc = time.time()
        curr_fps = 1.0 / (toc-tic)
        fps = curr_fps if fps==0.0 else (fps*0.95 + curr_fps*0.05)
        tic = toc

        # 키보드 입력을 위해 1ms 동안 대기, 입력이 없으면 -1을 리턴
        key = cv2.waitKey(1)
        if key == 27:
            # ESC를 눌렀을 경우
            break
        elif key == ord("F") or key == ord("f"):
            # F나 f를 눌렀을 경우 전체 스크린 토클 기능
            full_scrn = not full_scrn
            if full_scrn:
                cv2.setWindowProperty("detect_from_video", cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)
            else:
                cv2.setWindowProperty("detect_from_video", cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_NORMAL)

#%% 메인 함수
def main():
    # 엔지 파일 경로
    from utils import camera
    enginePath = project_path + "/models/ssd_mobilenet_v2_object_model/tensorrt_fp16.engine"
    # 비디오 캡처 객체 얻기
    camera = camera.Video_Setting()
    videoCapture = camera.video_read()

    # videoCapture.set(cv2.CAP_PROP_FRAME_WIDTH, 320)
    # videoCapture.set(cv2.CAP_PROP_FRAME_HEIGHT, 240)

    # 감지 결과(생산)와 처리(소비)를 동기화를 위한 Condition 얻기
    condition = threading.Condition()
    # TrtThread 객체 생성
    trtThread = TrtThread(enginePath, TrtThread.INPUT_TYPE_VIDEO, videoCapture, 0.6, condition)
    # 감지 시작
    trtThread.start()

    # 이름있는 윈도우 만들기
    cv2.namedWindow("detect_from_video", cv2.WINDOW_NORMAL)
    cv2.resizeWindow("detect_from_video", 320, 240)
    cv2.setWindowTitle("detect_from_video", "detect_from_video")

    # 감지 결과 처리(활용)
    handleDetectedObject(trtThread, condition)

    # 감지 중지
    trtThread.stop()

    # VideoCapture 중지
    videoCapture.release()

    # 윈도우 닫기
    cv2.destroyAllWindows()


#%% 최상위 스크립트 실행
if __name__ == "__main__":
    main()


