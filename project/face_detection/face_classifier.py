import tensorflow as tf
import cv2
import numpy as np
from face_detection.face_label_map import CLASSES_DICT
import dlib


class FaceClassifier:
    def __init__(self):
        self.saved_model = tf.keras.models.load_model(
            'C:/MyWorkspace/datasets/object-detection/project/dataset/tfmodel/saved_model')
        self.infer_fun = self.saved_model.signatures['serving_default']
        self.detector = dlib.get_frontal_face_detector()

    def classify(self, img):
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        faces = self.detector(gray)

        for rect in faces:  # dlib로 얼굴인식 후 좌표값을 리턴
            left, right, bottom, top = rect.left(), rect.right(), rect.bottom(), rect.top()
            input = img[min(int(bottom), int(top)):max(int(bottom), int(top)),
                    min(int(left), int(right)):max(int(left), int(right))]
            input = cv2.resize(input, dsize=(200, 200))
            input = cv2.cvtColor(input, cv2.COLOR_BGR2GRAY)
            input = input / 255.
            input = input[..., np.newaxis]
            input = input[np.newaxis, ...]

            output = self.saved_model.predict_classes(input)
            perd = self.saved_model.predict(input)
            score = max(perd[0])
            print(output)
            img = cv2.rectangle(img, (left, top), (right, bottom), (255, 255, 0), 2)

            class_text = CLASSES_DICT[int(output[0])]+"({:.0f}%)".format(score*100)
            print(class_text)
            img = cv2.putText(img, class_text, (left + 10, top - 10), cv2.FONT_HERSHEY_COMPLEX_SMALL, 0.7,
                              (255, 255, 255), 1)
        return img


if __name__ == '__main__':
    classifier = FaceClassifier()
