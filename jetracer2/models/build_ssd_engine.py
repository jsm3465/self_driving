import os
import sys

#%% 프로젝트 폴더를 sys.path에 추가(Jetson Nano에서 직접 실행할 때 필요)
# project_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
project_path = "/home/jetson/MyWorkspace/jetracer"
sys.path.append(project_path)
from utils import trt_ssd_engine

#%% 샘플 함수
def sample1():
    # ------------------------------------------------------------------------------------
    # 사용하고자 하는 Object Detection 모델 타입
    # 다음 중 하나 지정: ssd_mobilenet_v1, ssd_mobilenet_v2, ssd_inception_v2)
    model_type = "ssd_mobilenet_v2"
    # 사전 훈련된 모델 경로
    model_path = os.path.join(project_path, "models/ssd_mobilenet_v2_model_9_60000")
    # 동결 추론 그래프 파일 이름
    pb_name = "frozen_inference_graph.pb"
    # 분류 수 (백그라운드 클래스 + 분류할 클래스 수 = 1 + 90)
    class_num = 28
    # 엔진 파일 생성
        # input_order: 입력 순서를 말하며 Squeeze(이미지데이터)가 0, concat_box_conf가 1, concat_priorbox가 2가 되어야 한다.
        # pb 파일을 TRT 엔진 파일로 바꿀 때마다 달라지므로 임시 순서를 먼저 주고 실행한다.
        # Assertion `numPriors * numLocClasses * 4 == inputDims[param.inputOrder[0]].d[0]' failed 에러가 발생할 경우
        # 임시 순서가 틀린 것이므로, 생성되는 tensorrt.pbtxt의 NMS 내용을 보고 올바르게 설정하고 재실행한다.
        # tensorrt.pbtxt
            # graphs {
            #     id: "main"
            #     nodes {
            #         id: "NMS"
            #         inputs: "Squeeze"             0
            #         inputs: "concat_priorbox"     2
            #         inputs: "concat_box_conf"     1
    trt_ssd_engine.build(model_type, model_path, pb_name, class_num, [0, 2, 1])

if __name__ == '__main__':
    sample1()
