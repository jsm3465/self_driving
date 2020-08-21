<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
      <title>Insert title here</title>
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
      <!-- mqtt -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
      <!-- 부트스트랩 slate -->
      <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
      <!-- width = 장치 화면 너비에 따라 페이지 너비 설정, initial-scale = 페이지가 처음 브라우저에 의해로드 된 초기 줌 레벨 -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/roverList.css">
	
	<script>
		$(function(){
	        objectclient = new Paho.MQTT.Client(location.hostname, 61617, new Date().getTime().toString()+"b");
	        objectclient.onMessageArrived = objectonMessageArrived;
	        objectclient.connect({onSuccess:objectonConnect, useSSL:true});
		});
		
		function objectonConnect() {
            console.log("object mqtt broker connected")
            objectclient.subscribe("/rover1/#");
            objectclient.subscribe("/rover2/#");
            objectclient.subscribe("/rover3/#");
        }
		
		function objectonMessageArrived(message) {
            if(message.destinationName == "/rover1/object") {
	            console.log("rover1", message.payloadString);
	            var rover1object = JSON.parse(message.payloadString);
	
	            if(rover1object.A){
	               coordinates1 = mapCoordinates.A;
	            } else if (rover1object.B){
	               coordinates1 = mapCoordinates.B;
	            } else if (rover1object.C){
	               coordinates1 = mapCoordinates.C;
	            } else if (rover1object.D){
	               coordinates1 = mapCoordinates.D;
	            } else if (rover1object.E){
	               coordinates1 = mapCoordinates.E;
	            } else if (rover1object.F){
	               coordinates1 = mapCoordinates.F;
	            } else if (rover1object.H){
	               coordinates1 = mapCoordinates.H;
	            } else if (rover1object.I){
	               coordinates1 = mapCoordinates.I;
	            } else if (rover1object.J){
	               coordinates1 = mapCoordinates.J;
	            } else if (rover1object.K){
	               coordinates1 = mapCoordinates.K;
	            } else if (rover1object.M){
	               coordinates1 = mapCoordinates.M;
	            } else if (rover1object.N){
	               coordinates1 = mapCoordinates.N;
	            } else if (rover1object.P){
	               coordinates1 = mapCoordinates.P;
	            } else if (rover1object.S){
	               coordinates1 = mapCoordinates.S;
	            } else if (rover1object.T){
	               coordinates1 = mapCoordinates.T;
	            }
			} 
            
            if(message.destinationName == "/rover2/object") {
				console.log("rover2", message.payloadString);
	            var rover2object = JSON.parse(message.payloadString);
	
	            if(rover2object.A){
	               coordinates2 = mapCoordinates.A;
	            } else if (rover2object.B){
	               coordinates2 = mapCoordinates.B;
	            } else if (rover2object.C){
	               coordinates2 = mapCoordinates.C;
	            } else if (rover2object.D){
	               coordinates2 = mapCoordinates.D;
	            } else if (rover2object.E){
	               coordinates2 = mapCoordinates.E;
	            } else if (rover2object.F){
	               coordinates2 = mapCoordinates.F;
	            } else if (rover2object.H){
	               coordinates2 = mapCoordinates.H;
	            } else if (rover2object.I){
	               coordinates2 = mapCoordinates.I;
	            } else if (rover2object.J){
	               coordinates2 = mapCoordinates.J;
	            } else if (rover2object.K){
	               coordinates2 = mapCoordinates.K;
	            } else if (rover2object.M){
	               coordinates2 = mapCoordinates.M;
	            } else if (rover2object.N){
	               coordinates2 = mapCoordinates.N;
	            } else if (rover2object.P){
	               coordinates2 = mapCoordinates.P;
	            } else if (rover2object.S){
	               coordinates2 = mapCoordinates.S;
	            } else if (rover2object.T){
	               coordinates2 = mapCoordinates.T;
	            }
			}
            
            if(message.destinationName == "/rover3/object") {
				console.log("rover3", message.payloadString);
	            var rover3object = JSON.parse(message.payloadString);
	
	            if(rover3object.A){
	               coordinates3 = mapCoordinates.A;
	            } else if (rover3object.B){
	               coordinates3 = mapCoordinates.B;
	            } else if (rover3object.C){
	               coordinates3 = mapCoordinates.C;
	            } else if (rover3object.D){
	               coordinates3 = mapCoordinates.D;
	            } else if (rover3object.E){
	               coordinates3 = mapCoordinates.E;
	            } else if (rover3object.F){
	               coordinates3 = mapCoordinates.F;
	            } else if (rover3object.H){
	               coordinates3 = mapCoordinates.H;
	            } else if (rover3object.I){
	               coordinates3 = mapCoordinates.I;
	            } else if (rover3object.J){
	               coordinates3 = mapCoordinates.J;
	            } else if (rover3object.K){
	               coordinates3 = mapCoordinates.K;
	            } else if (rover3object.M){
	               coordinates3 = mapCoordinates.M;
	            } else if (rover3object.N){
	               coordinates3 = mapCoordinates.N;
	            } else if (rover3object.P){
	               coordinates3 = mapCoordinates.P;
	            } else if (rover3object.S){
	               coordinates3 = mapCoordinates.S;
	            } else if (rover3object.T){
	               coordinates3 = mapCoordinates.T;
	            }
			}
		}
		
		$(function() {
            // Publisher Connection
            publisher = new Paho.MQTT.Client(location.hostname, 61617,
                  new Date().getTime().toString()+"c");
            publisher.connect({
               onSuccess : onPublisherConnect,
               useSSL:true
            });
         });

         function onPublisherConnect() {
            console.log("mqtt broker publisher connected");
         }

         var keyset = [];
         $(function(){
            console.log('event ready')
               document.addEventListener('keydown', function(e) {
                const keyCode = e.keyCode;
                console.log(keyCode);

                keyset[keyCode] = true;
            })

         })

         setInterval(function () {
               if(keyset[32]){
                  stop();
               }

               if(keyset[37]){
                  left();
               }

               if(keyset[38]){
                  forward();
               }

               if(keyset[39]){
                  right();
                 }

               if(keyset[40]){
                  backward();
               }

               if(keyset[81]){
                  AIstart();
               }

               if(keyset[87]){
                  AIend();
               }
         }, 150);

         function forward() {
            console.log("forward")
            var message = new Paho.MQTT.Message("forward");
            message.destinationName = "/rover3/order/mode2/direction";
            publisher.send(message);
         }

         function backward() {
            var message = new Paho.MQTT.Message("backward");
            message.destinationName = "/rover3/order/mode2/direction";
            publisher.send(message);
         }

         function stop() {
            var message = new Paho.MQTT.Message("stop");
            message.destinationName = "/rover3/order/mode2/direction";
            publisher.send(message);
         }

         function left() {
            var message = new Paho.MQTT.Message("left");
            message.destinationName = "/rover3/order/mode2/direction";
            publisher.send(message);
         }

         function right() {
            var message = new Paho.MQTT.Message("right");
            message.destinationName = "/rover3/order/mode2/direction";
            publisher.send(message);
         }

         function AIstart() {
            var message = new Paho.MQTT.Message("start");
            message.destinationName = "/rover3/order/mode1";
            publisher.send(message);
         }

         function AIend() {
            var message = new Paho.MQTT.Message("end");
            message.destinationName = "/rover3/order/mode1";
            publisher.send(message);
         }

         $(function() {
            document.addEventListener('keyup', function(e) {
                  const keyCode = e.keyCode;
                  console.log('pushed key ' + e.key);
                  keyset[keyCode] = false;
                 var message = new Paho.MQTT.Message("keyboardup");
                 message.destinationName = "/rover3/order";
                 publisher.send(message);
               })
         })
	</script>
	
	<style>
		canvas {position: absolute;}
		#carLayer {z-index: 5;}
		#mapLayer {z-index: 4;}
	</style>
</head>

<body>
	<div class="fluid-container vh-100">
		<header class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<h1>Control Center</h1>
			</div>
			<div id="userIdDiv" class="col-3">
				${sessionMid}
			</div>
		</header>
		<section class="row">
			<div id="roverList" class="col-4">
				<h3>Select Car</h3>
				<c:forEach var="rover" items="${roverList}">
				<form method="post" action="selectMode.do">
					<input type="hidden" name="rname" value="${rover.rname}"/>
					<button id="${rover.rname}" type="submit"
						class="btn btn-outline-info btn-block">${rover.rname}
						<span class="badge badge-secondary">${rover.ruser}</span>
					</button>
				</form>
				</c:forEach>
				<form id="resisterRoverForm" action="resisterRoverForm.do"></form>
				<button id="resisterRoverFormButton" type="submit"
					class="btn btn-outline-info btn-block" form="resisterRoverForm">+</button>
			</div>
			<div class="col-8">
				<h3>Map</h3>
				<div>
					<canvas id="mapLayer"></canvas>
      				<canvas id="carLayer"></canvas>
				</div>
			</div>
		</section>
		<footer class="row"> </footer>
	</div>
	
	<script>
		var mapLayer = document.getElementById("mapLayer");
	    mapLayer.width = 750;
	    mapLayer.height = 750;
	    var mapLayerctx = mapLayer.getContext("2d");
	    var scale = mapLayer.width / 500;
	    mapLayerctx.scale(scale, scale);
	    drawMap();
		
	    var carLayer = document.getElementById("carLayer");
	    carLayer.width = 750;
	    carLayer.height = 750;
	    var carLayerctx = carLayer.getContext("2d");
	    carLayerctx.scale(scale, scale);
	    
	    var coordinates1;
	    var coordinates2;
	    var coordinates3;
	    
	    setInterval(drawCar, 500);

        var blink = false;

        // 자동차 그리기
        function drawCar() {
           if(blink) {
              carLayerctx.clearRect(0, 0, carLayer.width / scale, carLayer.height / scale);
              blink = false;
           }
           else {
           	if(coordinates1){
	       		carLayerctx.fillStyle = "red";
	            carLayerctx.strokeStyle = "red";
	            carLayerctx.beginPath();
	            carLayerctx.arc(coordinates1[0], coordinates1[1], 10, 0, 2 * Math.PI);
	            carLayerctx.fill()
	            blink = true;
           	}
           	if(coordinates2){
           		carLayerctx.fillStyle = "green";
	            carLayerctx.strokeStyle = "green";
	            carLayerctx.beginPath();
	            carLayerctx.arc(coordinates2[0], coordinates2[1], 10, 0, 2 * Math.PI);
	            carLayerctx.fill()
	            blink = true;
        	}
           	if(coordinates3){
           		carLayerctx.fillStyle = "blue";
	            carLayerctx.strokeStyle = "blue";
	            carLayerctx.beginPath();
	            carLayerctx.arc(coordinates3[0], coordinates3[1], 10, 0, 2 * Math.PI);
	            carLayerctx.fill()
	            blink = true;
        	}
           }
        }
	    
	    var mapCoordinates = {
	            A: [400, 50],
	            B: [315, 50],
	            C: [230, 50],
	            D: [150, 50],
	            E: [100, 100],
	            F: [100, 150],
	            H: [50, 300],
	            I: [50, 350],
	            J: [100, 400],
	            K: [150, 450],
	            M: [275, 450],
	            N: [400, 450],
	            P: [450, 310],
	            S: [450, 205],
	            T: [450, 100]
	         };
	
		function drawMap () {
	        var ctx = mapLayerctx;
	        ctx.globalAlpha = 0.2;
	
	        ctx.beginPath(); // path 시작 함수, path를 초기화 또는 재설정
	        ctx.lineWidth = 10 // path의 굴기 설정
	        ctx.strokeStyle = "white"; // path의 색 설정
	        ctx.moveTo(150, 50); // path의 시작점
	        ctx.lineTo(400, 50); // 해당 좌표로 직선 이어주기
	        ctx.arcTo(450, 50, 450, 100, 50); // 해당 좌표로 곡선 이어주기
	
	        ctx.lineTo(450, 400);
	        ctx.arcTo(450, 450, 400, 450, 50);
	
	        ctx.lineTo(150, 450);
	        ctx.bezierCurveTo(130, 450, 130, 400, 100, 400); // 해당 좌표로 bezier curve 이어주기
	        ctx.arcTo(50, 400, 50, 350, 50);
	
	        ctx.lineTo(50, 300);
	        ctx.lineTo(100, 150);
	        ctx.lineTo(100, 100);
	        ctx.arcTo(100, 50, 150, 50, 50);
	
	        ctx.stroke(); // 위에서 이어준 좌표 실제로 그리기
	     }
	</script>
	
	<script
		src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
</body>
</html>