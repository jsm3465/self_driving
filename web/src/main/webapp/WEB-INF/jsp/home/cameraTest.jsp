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
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime.toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/camerapub/#");
			}
			
			function onMessageArrived(message) {
				if(message.destinationName == "/camerapub/rover1") {
					var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);	
				}
			}
			
			
			$(function() {
			   // Publisher Connection
			   publisher = new Paho.MQTT.Client(location.hostname, 61614,
			         new Date().getTime().toString());
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
			      
			      if(keyset[69]){
			    	  refront();
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
				message.destinationName = "/order/rover1/mode2/direction";
				publisher.send(message);
			}

			function backward() {
			   var message = new Paho.MQTT.Message("backward");
			   message.destinationName = "/order/rover1/mode2/direction";
			   publisher.send(message);
			}

			function stop() {
			   var message = new Paho.MQTT.Message("stop");
			   message.destinationName = "/order/rover1/mode2/direction";
			   publisher.send(message);
			}

			function left() {
			   var message = new Paho.MQTT.Message("left");
			   message.destinationName = "/order/rover1/mode2/direction";
			   publisher.send(message);
			}

			function right() {
			   var message = new Paho.MQTT.Message("right");
			   message.destinationName = "/order/rover1/mode2/direction";
			   publisher.send(message);
			}
			
			function refront() {
			   var message = new Paho.MQTT.Message("refront");
			   message.destinationName = "/order/rover1/mode2/direction";
			   publisher.send(message);
			}
			
			function AIstart() {
			   var message = new Paho.MQTT.Message("start");
			   message.destinationName = "/order/rover1/mode1";
			   publisher.send(message);
			}
			
			function AIend() {
			   var message = new Paho.MQTT.Message("end");
			   message.destinationName = "/order/rover1/mode1";
			   publisher.send(message);
			}
			
			$(function() {
				document.addEventListener('keyup', function(e) {
		      		const keyCode = e.keyCode;
		      		console.log('pushed key ' + e.key);
		    	  	keyset[keyCode] = false;
			  		var message = new Paho.MQTT.Message("keyboardup");
			  		message.destinationName = "/order/rover1";
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