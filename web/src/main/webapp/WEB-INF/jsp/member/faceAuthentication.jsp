<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Face Authentication</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
	<%-- <script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script> --%>
	<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
	<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/faceAuthentication.css">

	<!-- Camera Access, MQTT -->
	<script>

		//인증 여부를 위한 HashMap 자료구조 정의
		HashMap = function(){
			this.map = new Array();
		}

		HashMap.prototype = {
			// key, value 데이터 추가
			put : function(key, value){
				this.map[key] = value;
			},

			// 지정한 key 값의 value 반환
			get : function(key){
				return this.map[key];
			},

			// HashMap에 key값 존재유무 반환
			containsKey: function(key){
				return key in this.map;
			}

			// 최대값을 갖는 key값 반환 -> 오류나는데 왜 그런지 생각해보기.
			/* maxKey: function(){
				var maxKey = null;
				var maxValue = 0;
				for(var temp in this.map){
					if(this.map[temp] > maxValue){
						maxValue = this.map[temp];
						maxKey = temp;
					}
				}
				console.log("maxValue="+maxValue);
				console.log("maxKey="+maxKey);
				return maxkey;
			} */
		}

		$(document).ready(function(){
			client = new Paho.MQTT.Client("192.168.3.242", 61617, new Date().getTime().toString());
			client.onMessageArrived = onMessageArrived;
			client.connect({onSuccess:onConnect, useSSL:true});

			var map = new HashMap();
			var realUser = "<%=(String)session.getAttribute("sessionMid")%>";
			var count=0;
			var maxKey="";
			var maxValue=0;

			function onConnect(){
				console.log("MQTT Broker 연결 성공");
				// 구독하기
				client.subscribe("/camerapub/faceID");
				client.subscribe("/authentication");
				// 카메라 캡처 시작하기
				cameraCapture();
			}

			function onMessageArrived(message){
				if(message.destinationName == "/camerapub/faceID"){
					var cameraView = $("#remoteView").attr("src", "data:image/jpg;base64,"+message.payloadString);
				}
				else if(message.destinationName == "/authentication"){
					console.log(message.payloadString);
					count++;
					var key = message.payloadString;

					if(map.containsKey(key)){
						console.log("있다!!");
						var cur = map.get(key);
						console.log(cur);
						map.put(key,cur+1);
						if(maxValue <cur+1){
							maxValue=cur+1;
							maxKey = key;
						}
					}
					else{
						console.log("없다!!");
						map.put(key,1);
						if(maxValue < 1){
							maxValue= 1;
							maxKey = key;
						}
					}

					if(count >=30){
						console.log("realUser:"+"\""+realUser+"\"");
						console.log("realUser:"+typeof(realUser));
						console.log(maxValue);
						console.log(maxKey);
						console.log("maxKey:"+typeof(maxKey));
						realUser ="\""+realUser+"\"";
						if(realUser == maxKey){
							client.disconnect();
						 	alert(realUser+"님, 인증에 성공 했습니다.");
					      	$("#next").attr("action", "../home/main.do");
					      	document.nextPage.submit();
						}
						else{
							client.disconnect();
							alert("인증에 실패 했습니다.");
						    $("#next").attr("action", "../home/redirectToMain.do");
						    document.nextPage.submit();
						}
					}
				}

			}

			//MQTT client로 base64 이미지 전송하기
			function sendBase64Image(base64Frame){
				/* var cameraView = document.querySelector("#localView");
			    cameraView.src = base64Frame; */
			    base64Frame=base64Frame.replace('data:image/jpeg;base64,', '');
				var message = new Paho.MQTT.Message(base64Frame);
				message.destinationName = "/camerapub/face";
				client.send(message);

			}

			//촬영하는 웹캠 비디오 이미지로 캡쳐하기
			function capture(video){
				//console.log(video);
				var w = 640;
				var h = 480;
				var canvas = document.createElement("canvas");
				canvas.width = 320;
				canvas.height = 240;
				canvas.getContext("2d").drawImage(video,0,0,320,240);

				//매개변수 -> 1.파일형식, 2.퀄리티
				base64Frame = canvas.toDataURL('image/jpeg',0.5);
				return base64Frame;
			}

			//웹캠으로 촬영하기 및 이미지 전송하기
			function cameraCapture(){
				var video = document.querySelector("#video");

				if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
					navigator.mediaDevices.getUserMedia({
						video : true
					}).then(function(stream) {
						console.log(stream);
						video.srcObject = stream;
						video.play();
					window.setInterval(function(){
							var base64Frame = capture(video);
							sendBase64Image(base64Frame);
						}, 100);
					});
				}
				else{
					console.log("외않되");
				}
			}
		});
	</script>

</head>
<body>

		<!-- 웹캠으로 촬영하는 이미지<br/> -->
		<video id="video" autoplay width="140px" height="140px" ></video>
		<!-- 전송 받은 이미지<br/>
		<img id="remoteView" width="640px" height="480px"/><br/> -->
		<!-- 내가 보내고 있는 이미지<br/>
		<img type="hidden" id="localView" /> -->


 	<div id="wrap" class="container-fulid vh-100">
		<header class="row">
			<div class="col-4"></div>
			<div id="notice" class="col-4">얼굴을 네모칸 중앙에 맞춰 주세요.</div>
			<div class="col-4"></div>
		</header>
		<section class="row">
			<div class="col-4"></div>
			<div id="angle" class="col-4">
				<img id="remoteView"/>
			</div>
			<div class="col-4"></div>
		</section>
		<footer class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<form id="next" name="nextPage"></form>
			</div>
			<div class="col-4"></div>
		</footer>
	</div>

</body>

</html>
