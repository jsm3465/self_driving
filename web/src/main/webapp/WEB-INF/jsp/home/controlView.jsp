<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cctvSctreen</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css" />
		<noscript>
			<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/noscript.css" />
		</noscript>
		<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/cctvScreen.css"> --%>
	</head>
	<body>
		<div class="container-fluid vw-100 vh-100">
			<header id="headerDiv" class="row">
				<div id="logoDiv" class="col-3" style="height:100%">
					<h3><a href="../home/main.do" id="logo">Autonomous Driving</a></h3>
				</div>
				<div id="titleDiv" class="col-6">
					<h2 id="title">CCTV Center</h2>
				</div>
				<div class="col-3"></div>
			</header>
			<section class="row">
				<div class="col-2"></div>
				<div class="col-8">
					<div id="cctvBox" class="row row-cols-2">
						<div id="cctv1" class="col">
							ROVER1
							<img id="cameraView"/>
						</div>
						<div id="cctv2" class="col">
							ROVER2
							<img id="cameraView2">
						</div>
						<div id="cctv3" class="col">
							ROVER3
							<img id="cameraView3">
						</div>
						<div id="cctv4" class="col">
							${sessionMid}
							<video id="video">
						</div>
					</div>
				</div>
				<div class="col-2"></div>
			</section>
			<footer class="row">
			</footer>
		</div>
		<script	src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/js/jquery.scrollex.min.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/js/jquery.scrolly.min.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/js/browser.min.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/js/breakpoints.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/util.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/main.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"
			    integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
				crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61617, new Date().getTime.toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect, useSSL:true});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/rover1/camerapub");
				client.subscribe("/rover2/camerapub");
				client.subscribe("/rover3/camerapub");
				
				cameraCapture();
			}
			
			function onMessageArrived(message) {
				//console.log(message.payloadString);
				if(message.destinationName == "/rover1/camerapub") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
					
					var pubmessage = new Paho.MQTT.Message("receive");
					   pubmessage.destinationName = "/rover1/order/receive";
					   publisher.send(pubmessage);	
				}
				else if(message.destinationName == "/rover2/camerapub") {
					var cameraView = $("#cameraView2").attr("src", "data:image/jpg;base64," + message.payloadString);
					
					var pubmessage = new Paho.MQTT.Message("receive");
					   pubmessage.destinationName = "/rover2/order/receive";
					   publisher.send(pubmessage);
				}
				else if(message.destinationName == "/rover3/camerapub") {
					var cameraView = $("#cameraView3").attr("src", "data:image/jpg;base64," + message.payloadString);
					
					var pubmessage = new Paho.MQTT.Message("receive");
					   pubmessage.destinationName = "/rover3/order/receive";
					   publisher.send(pubmessage);
				}
				
			}
			
			$(function() {
			   // Publisher Connection
			   publisher = new Paho.MQTT.Client(location.hostname, 61617,
			         new Date().getTime().toString()+"d");
			   publisher.connect({
			      onSuccess : onPublisherConnect,
			      useSSL:true
			   });
			});

			function onPublisherConnect() {
			   console.log("mqtt broker publisher connected");
			}
			
			function cameraCapture(){
				var video = document.querySelector("#video");

				if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
					navigator.mediaDevices.getUserMedia({
						video : true
					}).then(function(stream) {
						console.log(stream);
						video.srcObject = stream;
						video.play();
					});
				}
				
			}

		</script>
	</body>
</html>