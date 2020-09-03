var roverName = $("#roverNameDiv").text();

tic = new Date().getTime()

function playBlackBox(i) {
	//console.log("블랙박스 시작");
	var rname = $("#roverNameDiv").text();
	//console.log(rname);
	$.ajax({
		// 비동기 요청 경로
		url : "https://192.168.3.242:8443/project/getImages.do",
		data : {
			rname : rname
		},
		// Callback
		success : function(data, testStatus, jqXHR) {
			console.log(i);
			$("#blackBoxImage").attr("src","data:image/jpg;base64," + data.item[i].img);
			if (i < Number(data.limit)) {
				playBlackBox(i+1);
			}
		}
	});
};

$(function(){
      client = new Paho.MQTT.Client("192.168.3.250", 61617, new Date().getTime().toString()+"a");
      client.onMessageArrived = onMessageArrived;
      client.connect({onSuccess:onConnect, useSSL:true});

      objectclient = new Paho.MQTT.Client("192.168.3.250", 61617, new Date().getTime().toString()+"b");
      objectclient.onMessageArrived = objectonMessageArrived;
      objectclient.connect({onSuccess:objectonConnect, useSSL:true});
   });

   function onConnect() {
      console.log("mqtt broker connected")
      client.subscribe("/" + roverName + "/camerapub");
   }

   function objectonConnect() {
      console.log("object mqtt broker connected")
      objectclient.subscribe("/" + roverName + "/#");
   }

   function onMessageArrived(message) {
      //console.log(message);
       if(message.destinationName == "/" + roverName + "/camerapub") {
          //var cameraView = $("#cameraView").attr("src", "data:image/jpg;base64," + message.payloadString);
          image.src = "data:image/jpg;base64," + message.payloadString;
          tic = toc
       }
       var pubmessage = new Paho.MQTT.Message("receive");
          pubmessage.destinationName = "/" + roverName + "/order/receive";
          publisher.send(pubmessage);
   }

   function objectonMessageArrived(message) {
    if(message.destinationName == "/" + roverName + "/navi") {
       drawRoute();
       drawStatus(message.payloadString);
    }
    
   if(message.destinationName == "/" + roverName + "/object") {
         console.log(message.payloadString);
         objectLayerctx.clearRect(0, 0, objectLayer.width, objectLayer.height);
         var roverobject = JSON.parse(message.payloadString);

         if(roverobject.road){
            var object = roverobject.road;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("road", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.A){
            drawLocation("A");
            coordinates = mapCoordinates.A;
            var object = roverobject.A;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("A", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.B){
            drawLocation("B");
            coordinates = mapCoordinates.B;
            var object = roverobject.B;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("B", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.C){
            drawLocation("C");
            coordinates = mapCoordinates.C;
            var object = roverobject.C;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("C", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.D){
            drawLocation("D");
            coordinates = mapCoordinates.D;
            var object = roverobject.D;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("D", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.E){
            drawLocation("E");
            coordinates = mapCoordinates.E;
            var object = roverobject.E;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("E", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.F){
            drawLocation("F");
            coordinates = mapCoordinates.F;
            var object = roverobject.F;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("F", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.H){
            drawLocation("H");
            coordinates = mapCoordinates.H;
            var object = roverobject.H;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("H", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.I){
            drawLocation("I");
            coordinates = mapCoordinates.I;
            var object = roverobject.I;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("I", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.J){
            drawLocation("J");
            coordinates = mapCoordinates.J;
            var object = roverobject.J;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("J", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.K){
            drawLocation("K");
            coordinates = mapCoordinates.K;
            var object = roverobject.K;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("K", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.M){
            drawLocation("M");
            coordinates = mapCoordinates.M;
            var object = roverobject.M;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("M", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.N){
            drawLocation("N");
            coordinates = mapCoordinates.N;
            var object = roverobject.N;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("N", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.P){
            drawLocation("P");
            coordinates = mapCoordinates.P;
            var object = roverobject.P;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("P", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.S){
            drawLocation("S");
            coordinates = mapCoordinates.S;
            var object = roverobject.S;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("S", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.T){
            drawLocation("T");
            coordinates = mapCoordinates.T;
            var object = roverobject.T;
            var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
            drawRect(boxArray);
            objectLayerctx.fillText("T", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.red){
               var object = roverobject.red;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("red", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.green) {
            var object = roverobject.green;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("green", object[0] * 3.75, object[1] * 3.75);
         } else if (roverobject.yellow) {
            var object = roverobject.yellow;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("yellow", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.crosswalk){
               var object = roverobject.crosswalk;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("crosswalk", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.schoolzone){
               var object = roverobject.schoolzone;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("schoolzone", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.curve){
               var object = roverobject.curve;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("curve", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.stop){
               var object = roverobject.stop;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("stop", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.sixty){
               var object = roverobject.sixty;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("60", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.hundred){
               var object = roverobject.hundred;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("100", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.speed){
               var object = roverobject.speed;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("speed", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.car){
               var object = roverobject.car;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("car", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.cone){
               var object = roverobject.cone;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("cone", object[0] * 3.75, object[1] * 3.75);
         }

         if(roverobject.bump){
               var object = roverobject.bump;
             var boxArray = [object[0], object[1], object[2] - object[0], object[3] - object[1]]
             drawRect(boxArray);
             objectLayerctx.fillText("bump", object[0] * 3.75, object[1] * 3.75);
         }
      }
      else if(message.destinationName == "/" + roverName + "/sensor") {
         //console.log(message.payloadString)
         roversensor = JSON.parse(message.payloadString);
         angle = roversensor.angle;
         speed = roversensor.dcmotor_speed;
         direction = roversensor.dcmotor_dir;
         //mode = roversensor.mode;
         battery = roversensor.battery;
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
             pubmessage.destinationName = "/" + roverName + "/order/receive";
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
        message.destinationName = "/" + roverName + "/order/mode2/direction";
        publisher.send(message);
   }

   function backward() {
         var message = new Paho.MQTT.Message("backward");
         message.destinationName = "/" + roverName + "/order/mode2/direction";
         publisher.send(message);
   }

   function stop() {
         var message = new Paho.MQTT.Message("stop");
         message.destinationName = "/" + roverName + "/order/mode2/direction";
         publisher.send(message);
   }

   function left() {
         var message = new Paho.MQTT.Message("left");
         message.destinationName = "/" + roverName + "/order/mode2/direction";
         publisher.send(message);
   }

   function right() {
        var message = new Paho.MQTT.Message("right");
         message.destinationName = "/" + roverName + "/order/mode2/direction";
         publisher.send(message);
   }

   function AIstart() {
         var message = new Paho.MQTT.Message("start");
         message.destinationName = "/" + roverName + "/order/mode1";
         publisher.send(message);
   }

   function AIend() {
         var message = new Paho.MQTT.Message("end");
         message.destinationName = "/" + roverName + "/order/mode1";
         publisher.send(message);
   }
   
   function navStart() {
     console.log("start");
      var message = new Paho.MQTT.Message(startPosition.options[startPosition.selectedIndex].text);
      message.destinationName = "/" + roverName + "/order/mode3/start";
      publisher.send(message);
      console.log("topic : " + "/" + roverName + "/order/mode3/start")
      console.log(message.payloadString);
   }

   function navEnd() {
     console.log("end");
      var message = new Paho.MQTT.Message(endPosition.options[endPosition.selectedIndex].text);
      message.destinationName = "/" + roverName + "/order/mode3/end";
      publisher.send(message);
      console.log("topic : " + "/" + roverName + "/order/mode3/end")
      console.log(message.payloadString);
   }
   
   function checkNav() {
      if(mode != "Navigation Mode"){
         alert("내비게이션 모드가 아닙니다.")
         return;
      }
      
      if(startPosition.selectedIndex == 0 || endPosition.selectedIndex == 0){
         alert("출발지점과 도착지점 모두 선택해주세요.");
         return;
      }
      if(startPosition.selectedIndex == endPosition.selectedIndex){
         alert("출발지점과 도착지점을 다르게 선택해주세요.");
         return;
      }
      navStart();
      navEnd();
      navStart();
      navEnd();
      navStart();
      navEnd();
      $("#aiMode").attr("disabled", true);
      $("#manualMode").attr("disabled", true);
      $("#navStart").attr("disabled", true);
      $("#startPosition").attr("disabled", true);
      $("#endPosition").attr("disabled", true);
      $("#navStop").attr("disabled", false);
   }
   
   function changeMode (select){
      mode = select;
      if(mode == "AI Mode"){
         $("#aiMode").attr("disabled", true);
         $("#manualMode").attr("disabled", false);
         $("#navMode").attr("disabled", false);
         $("#startPosition").attr("disabled", true);
         $("#endPosition").attr("disabled", true);
         $("#navStart").attr("disabled", true);
         $("#navStop").attr("disabled", true);
      }
      if(mode == "Manual Mode"){
         $("#aiMode").attr("disabled", false);
         $("#manualMode").attr("disabled", true);
         $("#navMode").attr("disabled", false);
         $("#startPosition").attr("disabled", true);
         $("#endPosition").attr("disabled", true);
         $("#navStart").attr("disabled", true);
         $("#navStop").attr("disabled", true);
      }
      if(mode == "Navigation Mode"){
         navMapLayerctx.clearRect(0, 0, navMapLayer.width / scale1, navMapLayer.height / scale1);
         drawMap(navMapLayerctx);
         $("#aiMode").attr("disabled", false);
         $("#manualMode").attr("disabled", false);
         $("#navMode").attr("disabled", true);
         $("#startPosition").attr("disabled", false);
         $("#endPosition").attr("disabled", false);
         $("#navStart").attr("disabled", false);
         $("#navStop").attr("disabled", true);
      }
      console.log(mode);
   }
   
   $(function() {
      document.addEventListener('keyup', function(e) {
            const keyCode = e.keyCode;
            console.log('pushed key ' + e.key);
            keyset[keyCode] = false;
           var message = new Paho.MQTT.Message("keyboardup");
           message.destinationName = "/" + roverName + "/order";
           publisher.send(message);
         })
   })
   
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
         drawMap(mapLayerctx);

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
         var mode = "Manual Mode";
         var battery;
         var coordinates;

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
            shapeLayerctx.fillText(mode, 20, 50);
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
         function drawMap (layerctx) {
            var ctx = layerctx;
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
         
         
         //navigation
         var navMapLayer = document.getElementById("navMapLayer");
         navMapLayer.width = 400;
         navMapLayer.height = 400;
         var navMapLayerctx = navMapLayer.getContext("2d");
         var scale1 = navMapLayer.width / 500;
         navMapLayerctx.scale(scale1, scale1);
         drawMap(navMapLayerctx);
         
         var startflag;
         var endflag;
         var routeflag = true;
         var routeX;
         var routeY;
         
         function drawRoute() {
            navMapLayerctx.clearRect(0, 0, navMapLayer.width / scale1, navMapLayer.height / scale1);
            drawMap(navMapLayerctx);
            startPosition = document.getElementById("startPosition");
            endPosition = document.getElementById("endPosition");
            
            startflag = match(startPosition.options[startPosition.selectedIndex].text);
            endflag = match(endPosition.options[endPosition.selectedIndex].text);
            
            if(startPosition.selectedIndex != 0 && endPosition.selectedIndex != 0) {
               routeX = startflag[0];
               routeY = startflag[1];
               while(routeflag){
                  drawPath(routeX, routeY)
               }
               routeflag = true;
            }
            
            if(startPosition.selectedIndex != 0) {
               drawFlag(startflag, "start");
            }
            
            if(endPosition.selectedIndex != 0) {
               drawFlag(endflag, "end");
            }
            
         }
         
         function drawPath(posX, posY){
            navMapLayerctx.globalAlpha = 1;
           navMapLayerctx.strokeStyle = "red"; 
           navMapLayerctx.lineWidth = 10;
            if(posX == 400 && posY == 50){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(315, 50);
               navMapLayerctx.stroke();
               routeX = 315;
               routeY = 50;
            }
            if(posX == 315 && posY == 50){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(230, 50);
               navMapLayerctx.stroke();
               routeX = 230;
               routeY = 50;
            }
            if(posX == 230 && posY == 50){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(150, 50);
               navMapLayerctx.stroke();
               routeX = 150;
               routeY = 50;
            }
            if(posX == 150 && posY == 50){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.arcTo(100, 50, 100, 100, 50);
               navMapLayerctx.stroke();
               routeX = 100;
               routeY = 100;
            }
            if(posX == 100 && posY == 100){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(100, 150);
               navMapLayerctx.stroke();
               routeX = 100;
               routeY = 150;
            }
            if(posX == 100 && posY == 150){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(50, 300);
               navMapLayerctx.stroke();
               routeX = 50;
               routeY = 300;
            }
            if(posX == 50 && posY == 300){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(50, 350);
               navMapLayerctx.stroke();
               routeX = 50;
               routeY = 350;
            }
            if(posX == 50 && posY == 350){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.arcTo(50, 400, 100, 400, 50);
               navMapLayerctx.stroke();
               routeX = 100;
               routeY = 400;
            }
            if(posX == 100 && posY == 400){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.bezierCurveTo(130, 400, 130, 450, 150, 450);
               navMapLayerctx.stroke();
               routeX = 150;
               routeY = 450;
            }
            if(posX == 150 && posY == 450){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(275, 450);
               navMapLayerctx.stroke();
               routeX = 275;
               routeY = 450;
            }
            if(posX == 275 && posY == 450){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(400, 450);
               navMapLayerctx.stroke();
               routeX = 400;
               routeY = 450;
            }
            if(posX == 400 && posY == 450){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.arcTo(450, 450, 450, 400, 50);
               navMapLayerctx.lineTo(450, 310)
               navMapLayerctx.stroke();
               routeX = 450;
               routeY = 310;
            }
            if(posX == 450 && posY == 310){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(450, 205)
               navMapLayerctx.stroke();
               routeX = 450;
               routeY = 205;
            }
            if(posX == 450 && posY == 205){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.lineTo(450, 100)
               navMapLayerctx.stroke();
               routeX = 450;
               routeY = 100;
            }
            if(posX == 450 && posY == 100){
               if(posX == endflag[0] && posY == endflag[1]) {routeflag = false; return}
               navMapLayerctx.beginPath();
               navMapLayerctx.moveTo(posX, posY);
               navMapLayerctx.arcTo(450, 50, 400, 50, 50);
               navMapLayerctx.stroke();
               routeX = 400;
               routeY = 50;
            }
         }
         
         function match(text) {
            if(text == "A"){return mapCoordinates.A}   
            else if(text == "B"){return mapCoordinates.B}
            else if(text == "C"){return mapCoordinates.C}
            else if(text == "D"){return mapCoordinates.D}
            else if(text == "E"){return mapCoordinates.E}
            else if(text == "F"){return mapCoordinates.F}
            else if(text == "H"){return mapCoordinates.H}
            else if(text == "I"){return mapCoordinates.I}
            else if(text == "J"){return mapCoordinates.J}
            else if(text == "K"){return mapCoordinates.K}
            else if(text == "M"){return mapCoordinates.M}
            else if(text == "N"){return mapCoordinates.N}
            else if(text == "P"){return mapCoordinates.P}
            else if(text == "S"){return mapCoordinates.S}
            else if(text == "T"){return mapCoordinates.T}
         }
         
         function drawFlag(coordinates, position) {
            navMapLayerctx.globalAlpha = 1;
            navMapLayerctx.lineWidth = 2;
            navMapLayerctx.fillStyle = "white"; 
            navMapLayerctx.strokeStyle = "white"; 
            navMapLayerctx.font = "30px Arial";
            
            navMapLayerctx.beginPath();
            navMapLayerctx.arc(coordinates[0], coordinates[1], 10, 0, 2 * Math.PI);
            navMapLayerctx.fill();
            navMapLayerctx.beginPath();
            navMapLayerctx.moveTo(coordinates[0], coordinates[1]);
            if(position == "start") {
               navMapLayerctx.lineTo(coordinates[0], coordinates[1] - 20);
               navMapLayerctx.textBaseline = "bottom";
               navMapLayerctx.textAlign = "center";
               navMapLayerctx.fillText(position, coordinates[0], coordinates[1] - 20);
            } else if (position == "end") {
               navMapLayerctx.lineTo(coordinates[0], coordinates[1] + 20);
               navMapLayerctx.textBaseline = "top";
               navMapLayerctx.textAlign = "center";
               navMapLayerctx.fillText(position, coordinates[0], coordinates[1] + 20);
            }
            navMapLayerctx.stroke();
         }
         
         function drawStatus(status) {
            navMapLayerctx.fillStyle = "white";
            navMapLayerctx.font = "50px Arial";
            navMapLayerctx.fillText(status, 250, 250)            
         }