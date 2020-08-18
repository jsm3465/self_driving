<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cctvSctreen</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<!-- bootswatch slate theme -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/cctvScreen.css">

		<script>
			$(function(){
				client = new Paho.MQTT.Client("192.168.3.179", 61617, new Date().getTime.toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect, useSSL:true});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/rover1/camerapub");
				client.subscribe("/rover2/camerapub");
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
			   publisher = new Paho.MQTT.Client("192.168.3.242", 61617,
			         new Date().getTime().toString()+"d");
			   publisher.connect({
			      onSuccess : onPublisherConnect,
			      useSSL:true
			   });
			});

			function onPublisherConnect() {
			   console.log("mqtt broker publisher connected");
			}

		</script>
	</head>
	<body>
		<div class="container-fluid vh-100">
			<header class="row">
				<div id="logo" class="col-3" style="height:100%">
					<a href="main.do">Autonomous Driving</a>
				</div>
				<div class="col-6">
					<h1>CCTV Center</h1>
				</div>
				<div class="col-3">
				</div>
			</header>
			<section class="row">
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
						</div>
						<div id="cctv4" class="col">
						</div>
					</div>
				</div>
				<div class="col-4">
				</div>
			</section>
			<footer class="row">
			</footer>
		</div>
	</body>
</html>