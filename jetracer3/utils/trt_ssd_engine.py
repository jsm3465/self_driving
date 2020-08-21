import os
import ctypes
import uff
import tensorrt as trt
import graphsurgeon as gs


def build(model_type, model_path, pb_name, num_classes, input_order):
    # input_order: 입력 순서를 말하며 Squeeze가 0, concat_box_conf가 1, concat_priorbox가 2가 되어야 한다.
    # pb 파일을 TRT 엔진 파일로 바꿀 때마다 달라지므로 임시 순서를 먼저 주고 실행한다.
    # Assertion `numPriors * numLocClasses * 4 == inputDims[param.inputOrder[0]].d[0]' failed 에러가 발생할 경우
    # 임시 순서가 틀린 것이므로, 생성되는 tensorrt.pbtxt의 다음 내용을 보고 올바르게 설정하고 재실행한다.
    # tensorrt.pbtxt
    # graphs {
    #     id: "main"
    #     nodes {
    #         id: "NMS"
    #         inputs: "Squeeze"             0
    #         inputs: "concat_priorbox"     2
    #         inputs: "concat_box_conf"     1

    # initialize
    ctypes.CDLL("../lib/libflattenconcat.so")
    TRT_LOGGER = trt.Logger(trt.Logger.INFO)
    trt.init_libnvinfer_plugins(TRT_LOGGER, '')

    input_pb_path = os.path.join(model_path, pb_name)
    output_uff_path = os.path.join(model_path, "tensorrt.uff")
    output_engine_path = os.path.join(model_path, "tensorrt_fp16.engine")

    # compile the model into TensorRT engine
    model_specs = {
        'ssd_mobilenet_v1': {
            'input_pb': input_pb_path,
            'tmp_uff': output_uff_path,
            'output_bin': output_engine_path,
            'num_classes': num_classes,
            'min_size': 0.2,
            'max_size': 0.95,
            'input_order': input_order,
        },
        'ssd_mobilenet_v2': {
            'input_pb': input_pb_path,
            'tmp_uff': output_uff_path,
            'output_bin': output_engine_path,
            'num_classes': num_classes,
            'min_size': 0.2,
            'max_size': 0.95,
            'input_order': input_order,
        },
        'ssd_inception_v2': {
            'input_pb': input_pb_path,
            'tmp_uff': output_uff_path,
            'output_bin': output_engine_path,
            'num_classes': num_classes,
            'min_size': 0.2,
            'max_size': 0.95,
            'input_order': input_order,
        },
    }

    spec = model_specs[model_type]
    input_dim = (3, 300, 300)

    dynamic_graph = add_plugin(
        gs.DynamicGraph(spec['input_pb']),
        model_type,
        spec,
        input_dim)

    _ = uff.from_tensorflow(
        dynamic_graph.as_graph_def(),
        output_nodes=['NMS'],
        output_filename=spec['tmp_uff'],
        text=True,
        debug_mode=False)

    with trt.Builder(TRT_LOGGER) as builder, builder.create_network() as network, trt.UffParser() as parser:
        builder.max_workspace_size = 1 << 28
        builder.max_batch_size = 1
        builder.fp16_mode = True            # F16 정밀도로 연산을 수행하는 엔진 생성
        # builder.int8_mode = True          # Jetson Nano에서는 지원하지 않음, Xavier에서만 지원함
        parser.register_input('Input', input_dim)
        parser.register_output('MarkOutput_0')
        parser.parse(spec['tmp_uff'], network)
        engine = builder.build_cuda_engine(network)
        buf = engine.serialize()
        with open(spec['output_bin'], 'wb') as f:
            f.write(buf)


def add_plugin(graph, model_type, spec, input_dim):
    numClasses = spec['num_classes']
    minSize = spec['min_size']
    maxSize = spec['max_size']
    inputOrder = spec['input_order']

    # Find and remove all Assert Tensorflow nodes from the graph
    all_assert_nodes = graph.find_nodes_by_op("Assert")
    graph.remove(all_assert_nodes, remove_exclusive_dependencies=True)

    # Find all Identity nodes and forward their inputs
    all_identity_nodes = graph.find_nodes_by_op("Identity")
    graph.forward_inputs(all_identity_nodes)

    Input = gs.create_plugin_node(
        name="Input",
        op="Placeholder",
        shape=(1,) + input_dim
    )

    PriorBox = gs.create_plugin_node(
        name="MultipleGridAnchorGenerator",
        op="GridAnchor_TRT",
        minSize=minSize,
        maxSize=maxSize,
        aspectRatios=[1.0, 2.0, 0.5, 3.0, 0.33],
        variance=[0.1, 0.1, 0.2, 0.2],
        featureMapShapes=[19, 10, 5, 3, 2, 1], # Resolution 300
        #featureMapShapes=[29, 15, 8, 4, 2, 1],  # Resolution 450
        numLayers=6
    )

    NMS = gs.create_plugin_node(
        name="NMS",
        op="NMS_TRT",
        shareLocation=1,
        varianceEncodedInTarget=0,
        backgroundLabelId=0,
        confidenceThreshold=0.3,
        nmsThreshold=0.6,
        topK=100,
        keepTopK=100,
        numClasses=numClasses,
        inputOrder=inputOrder,
        confSigmoid=1,
        isNormalized=1
    )

    concat_priorbox = gs.create_node(
        "concat_priorbox",
        op="ConcatV2",
        axis=2
    )

    concat_box_loc = gs.create_plugin_node(
        "concat_box_loc",
        op="FlattenConcat_TRT",
    )

    concat_box_conf = gs.create_plugin_node(
        "concat_box_conf",
        op="FlattenConcat_TRT",
    )

    namespace_plugin_map = {
        "MultipleGridAnchorGenerator": PriorBox,
        "Postprocessor": NMS,
        "Preprocessor": Input,
        "ToFloat": Input,
        "image_tensor": Input,
        "MultipleGridAnchorGenerator/Concatenate": concat_priorbox,  # for 'ssd_mobilenet_v1_coco'
        "Concatenate": concat_priorbox,  # for other models
        "concat": concat_box_loc,
        "concat_1": concat_box_conf
    }

    graph.collapse_namespaces(namespace_plugin_map)
    graph.remove(graph.graph_outputs, remove_exclusive_dependencies=False)
    if model_type != "ssd_mobilenet_v2":
        graph.find_nodes_by_name("Input")[0].input.remove("image_tensor:0")
    graph.find_nodes_by_op("NMS_TRT")[0].input.remove("Input")

    return graph


