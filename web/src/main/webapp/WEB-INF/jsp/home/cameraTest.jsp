<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<!-- mqtt -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<!-- 부트스트랩 slate -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<!-- width = 장치 화면 너비에 따라 페이지 너비 설정, initial-scale = 페이지가 처음 브라우저에 의해로드 된 초기 줌 레벨 -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime.toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});

			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/camerapub");
			}

			function onMessageArrived(message) {
				if(message.destinationName == "/camerapub") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
				}
			}
		</script>
	</head>
	<body>
		<div class="container-fluid vh-100">
			<div style="border: solid 3px; height: 20%"class="row">
				<div style="border: solid 3px;"class="col-md-3">
					<a href="main.do"><img src="${pageContext.request.contextPath}/resource/img/logo.png"></a>
				</div>
				<div style="border: solid 3px;"class="col-md-6"></div>
				<div style="border: solid 3px;"class="col-md-3"></div>
			</div>
			<div style="border: solid 3px; height: 60%"class="row">
				<div style="border: solid 3px;"class="col-md-3"></div>
				<div style="border: solid 3px;"class="col-md-6">
					<!-- <img id="cameraView"/> -->
					<img style="position: absolute; top:0; left:0; width: 100%; height: 100%;"src="${pageContext.request.contextPath}/resource/img/background.jpg" />
				</div>
				<div style="border: solid 3px;"class="col-md-3"></div>
			</div>
			<div style="border: solid 3px; height: 20%"class="row">
				<div style="border: solid 3px;"class="col-md-3"></div>
				<div style="border: solid 3px;"class="col-md-6"></div>
				<div style="border: solid 3px;"class="col-md-3"></div>
			</div>
		</div>
	</body>
</html>
