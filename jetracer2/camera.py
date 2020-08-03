import cv2

class Video_Setting:
    def __init__(self):
        pass

    def gstreamer_pipeline(
        # self, capture_width=1280, capture_height=720,
        # display_width=1280, display_height=720,
        # framerate=60, flip_method=0,):
        self, capture_width=640, capture_height=360,
        display_width=320, display_height=240,
        framerate=60, flip_method=0 ):

        return (
            "nvarguscamerasrc ! "
            "video/x-raw(memory:NVMM), "
            "width=(int)%d, height=(int)%d, "
            "format=(string)NV12, framerate=(fraction)%d/1 ! "
            "nvvidconv flip-method=%d ! "
            "video/x-raw, width=(int)%d, height=(int)%d, format=(string)BGRx ! "
            "videoconvert ! "
            "video/x-raw, format=(string)BGR ! appsink"
            % (
                capture_width,
                capture_height,
                framerate,
                flip_method,
                display_width,
                display_height,
            )
        )
    def video_read(self):
        video = cv2.VideoCapture(self.gstreamer_pipeline(flip_method=0), cv2.CAP_GSTREAMER)
        return video


if __name__ == '__main__':
    camera = Video_Setting()
    video = camera.video_read()
    print("start")
    while True:
        ret, frame = video.read()
        cv2.imshow("c", frame)

        if cv2.waitKey(1) == 27:
            break