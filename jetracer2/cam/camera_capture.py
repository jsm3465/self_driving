import cv2
import numpy as np
import sys

project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)

def main():
    from utils import camera
    # %% 비디오 파일 로딩
    camera = camera.Video_Setting()
    videoCapture = camera.video_read()

    # %% 비디오 캡쳐 영상을 윈도우상에 보여주기
    count = 0
    num = 1
    while True:
        retval, frame = videoCapture.read()
        # frame = cv2.cv2.rotate(frame, cv2.ROTATE_90_CLOCKWISE)
        if not retval:
            break
        cv2.imshow('video', frame)
        if count == 1:
            img = np.copy(frame)
            # img = cv2.resize(img, dsize=(500, 330))
            cv2.imwrite('/home/jetson/MyWorkspace/jetracer/capture/' + str(num) + '.jpg', img)
            num += 1
        key = cv2.waitKey(1)
        count += 1
        if count == 20:
            count -= 20
        if key == 27:
            break

    # %% 리소스 해제
    if videoCapture.isOpened():
        videoCapture.release()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()