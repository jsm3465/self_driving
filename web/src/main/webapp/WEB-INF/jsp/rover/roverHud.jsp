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
      <script>
//          $(function(){
//             client = new Paho.MQTT.Client("192.168.3.250", 61614, new Date().getTime.toString());
//             client.onMessageArrived = onMessageArrived;
//             client.connect({onSuccess:onConnect});
//          });

//          function onConnect() {
//             console.log("mqtt broker connected")
//             client.subscribe("/camerapub");
//          }

//          function onMessageArrived(message) {
//             //console.log(message);
//             if(message.destinationName == "/camerapub") {
//                //var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
//                image.src = "data:image/jpg;base64," + message.payloadString;
//             }
//          }

         tic = new Date().getTime()

         $(function(){
               client = new Paho.MQTT.Client(location.hostname, 61617, new Date().getTime().toString()+"a");
               client.onMessageArrived = onMessageArrived;
               client.connect({onSuccess:onConnect, useSSL:true});

               objectclient = new Paho.MQTT.Client(location.hostname, 61617, new Date().getTime().toString()+"b");
               objectclient.onMessageArrived = objectonMessageArrived;
               objectclient.connect({onSuccess:objectonConnect, useSSL:true});
            });

            function onConnect() {
               console.log("mqtt broker connected")
               client.subscribe("/rover1/camerapub");
            }

            function objectonConnect() {
               console.log("object mqtt broker connected")
               objectclient.subscribe("/rover1/#");
            }

            function onMessageArrived(message) {
               //console.log(message);
                if(message.destinationName == "/rover1/camerapub") {
                   //var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
                   image.src = "data:image/jpg;base64," + message.payloadString;
                   tic = toc
                }
                var pubmessage = new Paho.MQTT.Message("receive");
                   pubmessage.destinationName = "/rover1/order/receive";
                   publisher.send(pubmessage);
            }

            function objectonMessageArrived(message) {
            if(message.destinationName == "/rover1/object") {
                  console.log(message.payloadString);
                  objectLayerctx.clearRect(0, 0, objectLayer.width, objectLayer.height);
                  var rover1object = JSON.parse(message.payloadString);

                  if(rover1object.road){
                	  var object = rover1object.road;
                      var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                      drawRect(boxArray);
                      objectLayerctx.fillText("road", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.A){
                     drawLocation("A");
                     coordinates = mapCoordinates.A;
                     var object = rover1object.A;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("A", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.B){
                     drawLocation("B");
                     coordinates = mapCoordinates.B;
                     var object = rover1object.B;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("B", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.C){
                     drawLocation("C");
                     coordinates = mapCoordinates.C;
                     var object = rover1object.C;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("C", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.D){
                     drawLocation("D");
                     coordinates = mapCoordinates.D;
                     var object = rover1object.D;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("D", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.E){
                     drawLocation("E");
                     coordinates = mapCoordinates.E;
                     var object = rover1object.E;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("E", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.F){
                     drawLocation("F");
                     coordinates = mapCoordinates.F;
                     var object = rover1object.F;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("F", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.H){
                     drawLocation("H");
                     coordinates = mapCoordinates.H;
                     var object = rover1object.H;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("H", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.I){
                     drawLocation("I");
                     coordinates = mapCoordinates.I;
                     var object = rover1object.I;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("I", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.J){
                     drawLocation("J");
                     coordinates = mapCoordinates.J;
                     var object = rover1object.J;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("J", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.K){
                     drawLocation("K");
                     coordinates = mapCoordinates.K;
                     var object = rover1object.K;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("K", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.M){
                     drawLocation("M");
                     coordinates = mapCoordinates.M;
                     var object = rover1object.M;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("M", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.N){
                     drawLocation("N");
                     coordinates = mapCoordinates.N;
                     var object = rover1object.N;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("N", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.P){
                     drawLocation("P");
                     coordinates = mapCoordinates.P;
                     var object = rover1object.P;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("P", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.S){
                     drawLocation("S");
                     coordinates = mapCoordinates.S;
                     var object = rover1object.S;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("S", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.T){
                     drawLocation("T");
                     coordinates = mapCoordinates.T;
                     var object = rover1object.T;
                     var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
                     drawRect(boxArray);
                     objectLayerctx.fillText("T", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.red){
	               	  var object = rover1object.red;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("red", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.green) {
                	  var object = rover1object.green;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("green", object[0] * 3.75, object[1] * 3.75);
                  } else if (rover1object.yellow) {
                	  var object = rover1object.yellow;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("yellow", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.crosswalk){
	               	  var object = rover1object.crosswalk;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("crosswalk", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.schoolzone){
	               	  var object = rover1object.schoolzone;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("schoolzone", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.curve){
	               	  var object = rover1object.curve;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("curve", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.stop){
	               	  var object = rover1object.stop;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("stop", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.sixty){
	               	  var object = rover1object.sixty;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("60", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.hundred){
	               	  var object = rover1object.hundred;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("100", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.speed){
	               	  var object = rover1object.speed;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("speed", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.car){
	               	  var object = rover1object.car;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("car", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.cone){
	               	  var object = rover1object.cone;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("cone", object[0] * 3.75, object[1] * 3.75);
                  }

                  if(rover1object.bump){
	               	  var object = rover1object.bump;
	                  var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
	                  drawRect(boxArray);
	                  objectLayerctx.fillText("bump", object[0] * 3.75, object[1] * 3.75);
                  }
               }
               else if(message.destinationName == "/rover1/sensor") {
                  //console.log(message.payloadString)
                  rover1sensor = JSON.parse(message.payloadString);
                  angle = rover1sensor.angle;
                  speed = rover1sensor.dcmotor_speed;
                  direction = rover1sensor.dcmotor_dir;
                  mode = rover1sensor.mode;
                  battery = rover1sensor.battery;
               }
            }

            $(function() {
               // Publisher Connection
               publisher = new Paho.MQTT.Client("192.168.3.250", 61617,
                     new Date().getTime().toString()+"c");
               publisher.connect({
                  onSuccess : onPublisherConnect,
                  useSSL:true
               });
            });

            function onPublisherConnect() {
               console.log("mqtt broker publisher connected");
            }

            setInterval(function(){
                toc = new Date().getTime()
                if(toc-tic > 3000){
                   var pubmessage = new Paho.MQTT.Message("receive");
                      pubmessage.destinationName = "/rover1/order/receive";
                      publisher.send(pubmessage);
                }
             },1000)

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
               message.destinationName = "/rover1/order/mode2/direction";
               publisher.send(message);
            }

            function backward() {
               var message = new Paho.MQTT.Message("backward");
               message.destinationName = "/rover1/order/mode2/direction";
               publisher.send(message);
            }

            function stop() {
               var message = new Paho.MQTT.Message("stop");
               message.destinationName = "/rover1/order/mode2/direction";
               publisher.send(message);
            }

            function left() {
               var message = new Paho.MQTT.Message("left");
               message.destinationName = "/rover1/order/mode2/direction";
               publisher.send(message);
            }

            function right() {
               var message = new Paho.MQTT.Message("right");
               message.destinationName = "/rover1/order/mode2/direction";
               publisher.send(message);
            }

            function AIstart() {
               var message = new Paho.MQTT.Message("start");
               message.destinationName = "/rover1/order/mode1";
               publisher.send(message);
            }

            function AIend() {
               var message = new Paho.MQTT.Message("end");
               message.destinationName = "/rover1/order/mode1";
               publisher.send(message);
            }

            $(function() {
               document.addEventListener('keyup', function(e) {
                     const keyCode = e.keyCode;
                     console.log('pushed key ' + e.key);
                     keyset[keyCode] = false;
                    var message = new Paho.MQTT.Message("keyboardup");
                    message.destinationName = "/rover1/order";
                    publisher.send(message);
                  })
            })
      </script>
      <style>
         canvas {position: absolute;}
         #objectLayer {z-index: 6;}
         #carLayer {z-index: 5; left: 20px; top: 585px;}
         #mapLayer {z-index: 4; left: 20px; top: 585px;}
         #locationLayer {z-index: 3;}
         #shapeLayer {z-index: 2;}
         #cameraLayer {z-index: 1;}
      </style>
   </head>
   <body>
      <canvas id="cameraLayer"></canvas>
      <canvas id="shapeLayer"></canvas>
      <canvas id="locationLayer"></canvas>
      <canvas id="mapLayer"></canvas>
      <canvas id="carLayer"></canvas>
      <canvas id="objectLayer"></canvas>

      <script>
         var cameraLayer = document.getElementById("cameraLayer");
         cameraLayer.width = 1200;
         cameraLayer.height = 900;
         var cameraLayerctx = cameraLayer.getContext("2d");

         var shapeLayer = document.getElementById("shapeLayer");
         shapeLayer.width = 1200;
         shapeLayer.height = 900;
         var shapeLayerctx = shapeLayer.getContext("2d");
         var shapeLayerctx2 = shapeLayer.getContext("2d");

         var objectLayer = document.getElementById("objectLayer");
         objectLayer.width = 1200;
         objectLayer.height = 900;
         var objectLayerctx = objectLayer.getContext("2d");

         var locationLayer = document.getElementById("locationLayer");
         locationLayer.width = 1200;
         locationLayer.height = 900;
         var locationLayerctx = locationLayer.getContext("2d");

         var mapLayer = document.getElementById("mapLayer");
         mapLayer.width = 300;
         mapLayer.height = 300;
         var mapLayerctx = mapLayer.getContext("2d");
         var scale = mapLayer.width / 500;
           mapLayerctx.scale(scale, scale);
           drawMap();

         var carLayer = document.getElementById("carLayer");
         carLayer.width = 300;
         carLayer.height = 300;
         var carLayerctx = carLayer.getContext("2d");
         carLayerctx.scale(scale, scale);

         var image = new Image();
         image.src="";

         var angle;
         var speed;
         var direction;
         var mode;
         var battery;
         var coordinates;

         //테스트 시작

//          image.src = "${pageContext.request.contextPath}/resource/image/road.jpg"
//          setInterval(test, 10);
//          angle = 30;
//          speed = 60;
//          direction = "forward";
//          mode = "manual";
//          battery = 3;
//          function test() {
//             shapeLayerctx.clearRect(0, 0, shapeLayer.width, shapeLayer.height);
//             if(angle){
//                drawArrow();
//             }
//             drawTime();
//             if(speed && direction){
//                drawSpeed();
//             }
//             if(mode){
//                drawMode();
//             }
//             if(battery){
//                drawBattery();
//             }
//          }

         //테스트 끝

         setInterval(drawCar, 500);

         var blink = false;

         // 자동차 그리기
         function drawCar() {
        	objectLayerctx.clearRect(0, 0, objectLayer.width, objectLayer.height);
            if(blink) {
               carLayerctx.clearRect(0, 0, carLayer.width / scale, carLayer.height / scale);
               blink = false;
            }
            else {
            	if(coordinates){
	               carLayerctx.beginPath();
	               carLayerctx.arc(coordinates[0], coordinates[1], 10, 0, 2 * Math.PI);
	               carLayerctx.fill()
	               blink = true;
            	}
            }
         }

         image.onload = function() {
            shapeLayerctx.clearRect(0, 0, shapeLayer.width, shapeLayer.height);
            cameraLayerctx.drawImage(image, 0, 0, 1200, 900);

            if(angle){
               drawArrow();
            }
            drawTime();
            if(speed && direction){
               drawSpeed();
            }
            if(mode){
               drawMode();
            }
            if(battery){
               drawBattery();
            }
         };

         shapeLayerctx.lineWidth = 5;
         shapeLayerctx.font = "30px Arial";
         shapeLayerctx.fillStyle = "white";
         shapeLayerctx.strokeStyle = "white";

         objectLayerctx.lineWidth = 1;
         objectLayerctx.font = "50px Arial";
         objectLayerctx.textBaseline = "top";
         objectLayerctx.fillStyle = "white";
         objectLayerctx.strokeStyle = "white";

         locationLayerctx.lineWidth = 1;
         locationLayerctx.font = "30px Arial";
         locationLayerctx.textBaseline = "top";
         locationLayerctx.fillStyle = "white";
         locationLayerctx.strokeStyle = "white";

         carLayerctx.fillStyle = "red";
         carLayerctx.strokeStyle = "red";

         // 객체감지후 확대 그리기
         function drawObject(arrayBox) {
            var rectX = arrayBox[0] * 3.75;
            var rectY = arrayBox[1] *3.75;
            var rectWidth = arrayBox[2] * 3.75;
            var rectHeight = arrayBox[3] * 3.75;
//             objectLayerctx.beginPath();
//             objectLayerctx.strokeRect(rectX, rectY, rectWidth, rectHeight);

//             var objectImage = new Image();
//             objectImage.src = cameraLayer.toDataURL();

            objectLayerctx.beginPath();
            objectLayerctx.moveTo(rectX, rectY);
            objectLayerctx.lineTo(450, 250);
            objectLayerctx.moveTo(rectX + rectWidth, rectY + rectHeight);
            objectLayerctx.lineTo(450 + rectWidth * 2, 250 + rectHeight * 2);
            objectLayerctx.stroke();

            //객체 확대
//             console.log(image);
//             objectLayerctx.drawImage(image, rectX, rectY, rectWidth, rectHeight, 450, 250, rectWidth * 2, rectHeight * 2);

//             cameraLayerctx.getImageData(rectX, rectY, rectWidth, rectHeight);
//             cameraLayerctx.putImageData(450, 250, rectWidth * 2, rectHeight * 2);
            objectLayerctx.strokeRect(450, 250, rectWidth * 2, rectHeight * 2);
         }

         // 각도 그리기
         function drawArrow() {
            shapeLayerctx.beginPath();
            shapeLayerctx.moveTo(600, 850);
            shapeLayerctx.quadraticCurveTo(600, 750, 600 - (angle * 100 / 30 ), 650);
            shapeLayerctx.stroke();

            if(angle>=0){
               shapeLayerctx.fillText(angle + "°", 540, 850);
            }

            if(angle<0){
               shapeLayerctx.fillText(-angle + "°", 620, 850);
            }
         }

         // 시간 그리기
         function drawTime() {
            var now = new Date();
             var hour = now.getHours();
             var minute = now.getMinutes();
             var ampm;
             if(hour>=12) {ampm = "pm";}
             else {ampm = "am"}
             if(hour>=13) {hour = hour - 12;}
             if(hour<10) {hour = "0" + hour;}
             if(minute < 10) {minute = "0" + minute;}
             shapeLayerctx.fillText(hour + " : " + minute + " " + ampm, 530, 50);
         }

         // 속도 그리기
         function drawSpeed() {
            shapeLayerctx.textAlign = "end";
            shapeLayerctx.fillText(direction, 1138, 800);
            shapeLayerctx.font = "60px Arial";
            shapeLayerctx.fillText(speed, 1100, 850);
            shapeLayerctx.font = "20px Arial";
            shapeLayerctx.textAlign = "start";
            shapeLayerctx.fillText("km", 1110, 825);
            shapeLayerctx.fillText("h", 1110, 850);
            shapeLayerctx.font = "30px Arial";
         }

         // 주행 모드 그리기
         function drawMode() {
            if(mode == "manual") {shapeLayerctx.fillText("Manual Mode", 20, 50);}
            if(mode == "AI") {shapeLayerctx.fillText("AI Mode", 20, 50);}
         }


         // 배터리 그리기
         function drawBattery() {
            if(battery >= 12.2) { battery = 12.2};
            battery1 = battery / 12.2 * 100;
            battery1 = Math.ceil(battery1);
            shapeLayerctx.textAlign = "end";
            shapeLayerctx.fillText(battery1 + "%", 1070, 50);
            shapeLayerctx.textAlign = "start";

            shapeLayerctx.lineWidth = 1;
            batterypoint = battery1 / 100 * 90;
            roundedRect(shapeLayerctx, 1080, 15, 100, 50, 15, "stroke");
            if(batterypoint >= 25) {
               roundedRect(shapeLayerctx, 1085, 20, batterypoint, 40, 10, "fill");
            } else {
               halfRoundedRect(shapeLayerctx, 1085, 20, batterypoint, 40, 10, "fill");
            }

            shapeLayerctx.beginPath();
            shapeLayerctx.arc(1175, 40, 15, 1.7 * Math.PI, 2.3 * Math.PI);
            shapeLayerctx.closePath();
            shapeLayerctx.fill();
            shapeLayerctx.lineWidth = 5;
         }

         // 배터리 그리기에 필요한 함수1
         function roundedRect(ctx, x, y, width, height, radius, type) {
            ctx.beginPath();
            ctx.moveTo(x, y + radius);
            ctx.lineTo(x, y + height - radius);
            ctx.arcTo(x, y + height, x + radius, y + height, radius);
            ctx.lineTo(x + width - radius, y + height);
            ctx.arcTo(x + width, y + height, x + width, y + height-radius, radius);
            ctx.lineTo(x + width, y + radius);
            ctx.arcTo(x + width, y, x + width - radius, y, radius);
            ctx.lineTo(x + radius, y);
            ctx.arcTo(x, y, x, y + radius, radius);
            if(type == "stroke") {ctx.stroke();}
            if(type == "fill") {ctx.fill();}
         }

         // 배터리 그리기에 필요한 함수2
         function halfRoundedRect(ctx, x, y, width, height, radius, type) {
            ctx.beginPath();
            ctx.moveTo(x, y + radius);
            ctx.lineTo(x, y + height - radius);
            ctx.arcTo(x, y + height, x + radius, y + height, radius);
            ctx.lineTo(x + width - radius, y + height);
            ctx.lineTo(x + width - radius, y);
            ctx.lineTo(x + radius, y);
            ctx.arcTo(x, y, x, y + radius, radius);
            if(type == "stroke") {ctx.stroke();}
            if(type == "fill") {ctx.fill();}
         }

         // 객체감지 그리기
         function drawRect(arrayBox) {
            var rectX = arrayBox[0] * 3.75;
            var rectY = arrayBox[1] *3.75;
            var rectWidth = arrayBox[2] * 3.75;
            var rectHeight = arrayBox[3] * 3.75;
            objectLayerctx.beginPath();
            objectLayerctx.strokeRect(rectX, rectY, rectWidth, rectHeight);
         }

         // 지도 좌표
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

         // 주행구간 그리기
         function drawLocation (loc) {
            locationLayerctx.clearRect(0, 0, locationLayer.width, locationLayer.height);
            locationLayerctx.fillText("주행구간 " + loc, 110, 560);
         }

         // 지도 그리기
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
   </body>
</html>
