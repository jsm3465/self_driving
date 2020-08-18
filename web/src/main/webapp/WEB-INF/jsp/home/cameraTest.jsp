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
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<script>
			tic = new Date().getTime()
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime.toString()+"b");
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
				
				objectclient = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime.toString()+"c");
				objectclient.onMessageArrived = objectonMessageArrived;
				objectclient.connect({onSuccess:objectonConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/rover2/camerapub");
			}
			
			function objectonConnect() {
				console.log("object mqtt broker connected")
				objectclient.subscribe("/rover2/object");
			}
			
			function onMessageArrived(message) {
				if(message.destinationName == "/rover2/camerapub") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
					tic = toc
				}
				var pubmessage = new Paho.MQTT.Message("receive");
				   pubmessage.destinationName = "/rover2/order/receive";
				   publisher.send(pubmessage);
			}
			function objectonMessageArrived(message) {
				if(message.destinationName == "/rover2/object") {
					console.log(message.payloadString)
				}
// 				if(message.destinationName == "/rover2/sensor") {
// 					console.log(message.payloadString)
// 				}
			}
			$(function() {
			   // Publisher Connection
			   publisher = new Paho.MQTT.Client(location.hostname, 61614,
			         new Date().getTime().toString()+"d");
			   publisher.connect({
			      onSuccess : onPublisherConnect
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

			setInterval(function(){
				toc = new Date().getTime()
				if(toc-tic > 3000){
// 					client.connect({onSuccess:onConnect});
					var pubmessage = new Paho.MQTT.Message("receive");
					   pubmessage.destinationName = "/rover2/order/receive";
					   publisher.send(pubmessage);
				}
			},1000)
			
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
			      
			      if(keyset[67]){
			    	  lanechange();
			      }
			      
			      if(keyset[69]){
			    	  maxspeed();
			      }
			      
			      if(keyset[81]){
			    	  AIstart();
			      }
			       
			      if(keyset[87]){
			    	  AIend();
			      }
			      
			}, 150);
			
			function maxspeed() {
				console.log("forward")
				var message = new Paho.MQTT.Message("maxspeed");
				message.destinationName = "/rover2/order/mode2/direction";
				publisher.send(message);
			}

			function forward() {
				console.log("forward")
				var message = new Paho.MQTT.Message("forward");
				message.destinationName = "/rover2/order/mode2/direction";
				publisher.send(message);
			}

			function backward() {
			   var message = new Paho.MQTT.Message("backward");
			   message.destinationName = "/rover2/order/mode2/direction";
			   publisher.send(message);
			}

			function stop() {
			   var message = new Paho.MQTT.Message("stop");
			   message.destinationName = "/rover2/order/mode2/direction";
			   publisher.send(message);
			}

			function left() {
			   var message = new Paho.MQTT.Message("left");
			   message.destinationName = "/rover2/order/mode2/direction";
			   publisher.send(message);
			}

			function right() {
			   var message = new Paho.MQTT.Message("right");
			   message.destinationName = "/rover2/order/mode2/direction";
			   publisher.send(message);
			}
			
			function lanechange() {
			   var message = new Paho.MQTT.Message("changestart");
			   message.destinationName = "/rover2/order/mode2/direction";
			   publisher.send(message);
			}
			
			function AIstart() {
			   var message = new Paho.MQTT.Message("start");
			   message.destinationName = "/rover2/order/mode1";
			   publisher.send(message);
			}
			
			function AIend() {
			   var message = new Paho.MQTT.Message("end");
			   message.destinationName = "/rover2/order/mode1";
			   publisher.send(message);
			}
			
			
			
			$(function() {
				document.addEventListener('keyup', function(e) {
		      		const keyCode = e.keyCode;
		      		console.log('pushed key ' + e.key);
		    	  	keyset[keyCode] = false;
			  		var message = new Paho.MQTT.Message("keyboardup");
			  		message.destinationName = "/rover2/order";
			  		publisher.send(message);	
		   		})
			})

		</script>
	</head>
	<body>
		<h5 class="alert alert-info">/home/cameraTest.jsp</h5>
		<img id="cameraView"/>
		
	</body>
</html>