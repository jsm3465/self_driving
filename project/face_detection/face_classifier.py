import tensorflow as tf
import cv2
import numpy as np
from face_detection.face_label_map import CLASSES_DICT
import dlib
import face_detection.align_dlib as align_dlib


class FaceClassifier:
    def __init__(self):
        self.saved_model = tf.keras.models.load_model(
            'C:/MyWorkspace/datasets/object-detection/project/dataset/model/saved_model')
        self.infer_fun = self.saved_model.signatures['serving_default']
        self.detector = dlib.get_frontal_face_detector()
        self.predictor_model = "C:/Myworkspace/project/face_detection/shape_predictor_68_face_landmarks.dat"
        self.face_detector = dlib.get_frontal_face_detector()
        self.face_aligner = align_dlib.AlignDlib(self.predictor_model)

    def classify(self, img):
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        faces = self.detector(gray)
        message = {}
        for rect in faces:  # dlib로 얼굴인식 후 좌표값을 리턴
            left, right, bottom, top = rect.left(), rect.right(), rect.bottom(), rect.top()
            alignedFace = self.face_aligner.align(534, img, rect,
                                                  landmarkIndices=align_dlib.AlignDlib.OUTER_EYES_AND_NOSE)
            input = cv2.resize(alignedFace, dsize=(224, 224))
            cv2.imshow("1", input)
            input = cv2.cvtColor(input, cv2.COLOR_BGR2GRAY)
            input = input / 255.
            input = input[np.newaxis, ..., np.newaxis]

            perd = self.saved_model.predict(input)
            perd = perd[0].tolist()
            score = max(perd)
            output = perd.index(max(perd))
            print(output)

            img = cv2.rectangle(img, (left, top), (right, bottom), (255, 255, 0), 2)

            class_text = CLASSES_DICT[int(output)] + "({:.0f}%)".format(score * 100)
            print(class_text)
            img = cv2.putText(img, class_text, (left + 10, top - 10), cv2.FONT_HERSHEY_COMPLEX_SMALL, 0.7,
                              (255, 255, 255), 1)
            message = {"cx": (left + right) / 2, "cy": (top + bottom) / 2, "mno": output}
        print(img.shape)
        return img


if __name__ == '__main__':
    import time

    fps = 0.0

    tic = time.time()

    classifier = FaceClassifier()

    cam = cv2.VideoCapture(0)
    cam.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    cam.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

    while (cam.isOpened()):
        returnValue, img = cam.read()
        if returnValue == False:
            break
        img = classifier.classify(img)
        cv2.imshow('', img)
        toc = time.time()
        curr_fps = 1.0 / (toc - tic)
        fps = curr_fps if fps == 0.0 else (fps * 0.8 + curr_fps * 0.2)
        print(fps)
        tic = toc
        if cv2.waitKey(1) == ord("q"):
            break
    cam.release()
    cv2.destroyAllWindows()
