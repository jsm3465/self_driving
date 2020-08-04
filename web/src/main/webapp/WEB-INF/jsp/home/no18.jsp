<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>No. 18</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<!-- bootswatch slate theme -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<!-- 나중에 .css 파일로 옮길것 -->
		<!-- border는 나중에 지울것 -->
		<style>
			* {
				border:solid 1px;
			}
			header {
				height:10%;
			}
			section {
				height:70%;
			}
			footer {
				height:20%;
			}
			#speedArea {
				height:20%;
			}
			#cameraArea {
				height:80%;
			}
			#cameraView {
				width:100%;
				height:100%;
			}
			#mapArea {
				width:100%;
				height:100%;
			}
			#map {
				width:100%;
				height:100%;
			}
			img {
				max-width:100%;
				max-height:100%;
			}
		</style>
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
				console.log(message)
				if(message.destinationName == "/camerapub") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);	
				}
			}
		</script>
	</head>
	<body>
		<div class="container-fluid vh-100">
			<header class="row">
				<div class="col-3" style="height:100%">
					<img src="${pageContext.request.contextPath}/resource/img/logo.png"/>
				</div>
				<div class="col-6">
					<h1>AI Mode</h1>
				</div>
				<div class="col-3">
				</div>
			</header>
			<section class="row">
				<div class="col-4">
					<div class="row" id="speedArea">
						<div class="col-4"></div>
						<div class="col-4"></div>
						<div class="col-4"></div>
					</div>
					<div class="row" id="cameraArea">
						<img id="cameraView"/>
					</div>
				</div>
				<div class="col-8" id="mapArea">
					<img id="map" src="${pageContext.request.contextPath}/resource/img/map.png"/>
				</div>
			</section>
			<footer class="row">
				<div class="col-3">
				</div>
				<div class="col-3">
				</div>
				<div class="col-3">
				</div>
				<div class="col-3">
				</div>
			</footer>
		</div>
	</body>
</html>