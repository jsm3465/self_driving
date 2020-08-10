<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<script
   src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<script
   src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>

<!-- capture -->
<script src="${pageContext.request.contextPath}/resource/js/imagecapture.js"></script>
   
<!-- Highcharts -->
<script
   src="${pageContext.request.contextPath}/resource/js/speed_direction.js"></script>
   
<!-- MQTT start -->   
<script
         src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
         type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resource/js/mqtt_subscriber.js"></script>
<!-- MQTT end -->

<!-- HighCharts -->

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
      
<!-- HighCharts Theme -->
<script src="https://code.highcharts.com/js/themes/dark-unica.js"></script>

<!-- HighCharts CSS -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/css/highcharts_gauge.css">
   
<!-- Toggle Switch CSS -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/css/toggle_switch.css">

<!-- Angles and sensors -->
      <!-- Highcharts -->
<%-- <script src="${pageContext.request.contextPath}/resource/js/speed_direction.js"></script> --%>
<script src="${pageContext.request.contextPath}/resource/js/camera_direction.js"></script>

<script src="${pageContext.request.contextPath}/resource/js/ultrasonic_direction.js"></script>

<script>
//---------------- publisher ----------------
$(function() {
   // Publisher Connection
   publisher = new Paho.MQTT.Client("192.168.3.179", 61614,
         new Date().getTime().toString());
   publisher.connect({
      onSuccess : onPublisherConnect
   });
});

function onPublisherConnect() {
   console.log("mqtt broker publisher connected");
}

// -------------- Keyboard Pressed --------------
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
          buzzer("on");
          console.log("32 눌림")
       }
       if(keyset[38]){
          forward();
          console.log("38 눌림")
       }
       if(keyset[40]){
          backward();
       }
       if(keyset[87]){
          cameraMoveUp();
       }
       if(keyset[83]){
          cameraMoveDown()
       }
       if(keyset[65]){
          cameraMoveLeft();
       }
       if(keyset[68]){
          cameraMoveRight();
       }
       if(keyset[82]){
          cameraMoveCenter();
       }
       if(keyset[49]){
          ledred("on");
       }
       if(keyset[50]){
          ledgreen("on");
       }
       if(keyset[51]){
          ledblue("on");
       }
       if(keyset[52]){
          ledoff("all");
       }
       if(keyset[37]){
          keyPressOrder(37)
       }
       if(keyset[39]){
          keyPressOrder(39)
       }
       if(keyset[97]){
          keyPressOrder(97)
       }
       if(keyset[13]){
          keyPressOrder(13)
       }
        }, 150);

function keyPressOrder(keyCode){

   message = new Paho.MQTT.Message(String(keyCode));
   message.destinationName = "/command/order"
   publisher.send(message);
}
// -------------- Keyboard Up --------------
$(function() {
   document.addEventListener('keyup', function(e) {
      const keyCode = e.keyCode;
      console.log('pushed key ' + e.key);
      
      keyset[keyCode] = false;
      if (keyCode == 32) { // Space키 - Buzzer 
         buzzer("off");
         
      }

      if (keyCode == 38 || keyCode == 40) { // forward, backward 키
         stop();
      }
      
   })
})

// -------------- Buzzer --------------
function buzzer(flag) {
   buzzer_flag = flag;
   console.log(flag)
   var temp = $("#p2").html();
   
   if(flag == "on") {
      $("#p2").html("ON");
      $("#buzzerbox").prop("checked", true);
   } else if(flag == "off"){
      $("#p2").html("OFF");
      $("#buzzerbox").prop("checked", false);
   }
   else {
      if(temp == "OFF"){
         $("#p2").html("ON");
         buzzer_flag="on"
      } else {
         $("#p2").html("OFF");
         buzzer_flag="off"
      }

   }
   
   var buzzer_message = new Paho.MQTT.Message(buzzer_flag);
   buzzer_message.destinationName = "/command/buzzer";
   publisher.send(buzzer_message);
   
}

// -------------- DC Motor --------------
var speed = 1000;

function forward() {
   if (speed >= 4095)
      speed = 4095;
   else
      speed += 20;
   setSpeed(speed);
   
   var message = new Paho.MQTT.Message("forward");
   message.destinationName = "/command/direction";
   publisher.send(message);
}

function backward() {
   if (speed >= 4095)
      speed = 4095;
   else
      speed += 20;
   setSpeed(speed);
   
   var message = new Paho.MQTT.Message("backward");
   message.destinationName = "/command/direction";
   publisher.send(message);
}

function stop() {
   var message = new Paho.MQTT.Message("stop");
   message.destinationName = "/command/direction";
   publisher.send(message);
   speed = 1000;
}

function setSpeed(speed) {
   var message = new Paho.MQTT.Message(speed.toString());
   message.destinationName = "/command/speed";
   publisher.send(message);
}

// ------------------ 카메라 서보 --------------
function cameraMoveUp(){
   message = new Paho.MQTT.Message("CameraUp");
    message.destinationName = "/command";
    console.log("CameraUp")
    publisher.send(message);
}
function cameraMoveDown(){
   message = new Paho.MQTT.Message("CameraDown");
    message.destinationName = "/command";
    console.log("CameraDown")
    publisher.send(message);
}
function cameraMoveLeft(){
   message = new Paho.MQTT.Message("CameraLeft");
    message.destinationName = "/command";
    console.log("CameraLeft")
    publisher.send(message);
}
function cameraMoveRight(){
   message = new Paho.MQTT.Message("CameraRight");
    message.destinationName = "/command";
    console.log("CameraRight")
    publisher.send(message);
}
function cameraMoveCenter(){
   message = new Paho.MQTT.Message("CameraCenter");
    message.destinationName = "/command";
    console.log("CameraCenter")
    publisher.send(message);
}

// -------------- Laser --------------
var laser_flag;

function laser() {
   var temp = $("#p1").html();

   if (laser_flag == "on") {
      laser_flag = "off";
   } else {
      laser_flag = "on";
   }

   var message = new Paho.MQTT.Message(laser_flag);
   message.destinationName = "/command/laser";
   publisher.send(message);

   if (temp == "ON") {
      $("#p1").html("OFF");
   } else {
      $("#p1").html("ON")
   }
}

// ------------------ led -----------------
function ledred(flag) {

   var temp = $("#p3").html();
   
   if(flag == "on") {
      $("#p3").html("ON");
      $("#ledredbox").prop("checked", true);
      ledoff("green");
      ledoff("blue");
   } else{
      if(temp == "OFF"){
         $("#p3").html("ON");
         ledoff("green");
         ledoff("blue");
      } else {
         $("#p3").html("OFF");
         ledoff();
         return;
      }
   }

   message = new Paho.MQTT.Message('LedRed');
   message.destinationName = "/command";
   console.log("red")
   publisher.send(message);
}

function ledgreen(flag) {
   
   var temp = $("#p4").html();
   
   if(flag == "on") {
      $("#p4").html("ON");
      $("#ledgreenbox").prop("checked", true);
      ledoff("red");
      ledoff("blue");
   } else{
      if(temp == "OFF"){
         $("#p4").html("ON");
         ledoff("red");
         ledoff("blue");
      } else {
         $("#p4").html("OFF");
         ledoff('green');
         return;
      }
   }
   
   console.log("green")
   message = new Paho.MQTT.Message('LedGreen');
   message.destinationName = "/command";
   publisher.send(message);
}

function ledblue(flag) {
   
   var temp = $("#p5").html();
   
   if(flag == "on") {
      $("#p5").html("ON");
      $("#ledbluebox").prop("checked", true);
      ledoff("green");
      ledoff("red");
   } else{
      if(temp == "OFF"){
         $("#p5").html("ON");
         ledoff("green");
         ledoff("red");
      } else {
         $("#p5").html("OFF");
         ledoff('blue');
         return;
      }
   }
   
   console.log("blue")
   message = new Paho.MQTT.Message('LedBlue');
   message.destinationName = "/command";
   publisher.send(message);
}

function ledoff(flag) {
   
   if(flag == "all"){
      $("#p3").html("OFF");
      $("#ledredbox").prop("checked", false);
      $("#p4").html("OFF");
      $("#ledgreenbox").prop("checked", false);
      $("#p5").html("OFF");
      $("#ledbluebox").prop("checked", false);
   } else if(flag == "red"){
      $("#p3").html("OFF");
      $("#ledredbox").prop("checked", false);
   } else if(flag == "green"){
      $("#p4").html("OFF");
      $("#ledgreenbox").prop("checked", false);
   } else if(flag == "blue"){
      $("#p5").html("OFF");
      $("#ledbluebox").prop("checked", false);
   }
   console.log("Ledoff")
   message = new Paho.MQTT.Message('LedOff');
   message.destinationName = "/command";
   publisher.send(message);
}

function LcdContentSend() {
         var str1 = $("#input1").val()
         var str2 = $("#input2").val()
         
         //LCD로 전달
         console.log("LCD1 전달")
         message = new Paho.MQTT.Message(str1);
         message.destinationName = "/command/lcd1";
         publisher.send(message);
         
         console.log("LCD2 전달")
         message = new Paho.MQTT.Message(str2);
         message.destinationName = "/command/lcd2";
         publisher.send(message);
}

// ------------------- UltraSonic ------------------------
var hcsr_angle = 90;

function hcsrMotor_down(direction) {
   if(direction == "left") {
      if (hcsr_angle >= 180)
         hcsr_angle = 180;
      else
         hcsr_angle += 30;
   }
   else if(direction == "right") {
      if (hcsr_angle <= 0)
         hcsr_angle = 0;
      else
         hcsr_angle -= 30;
   }
   else
      hcsr_angle = 90;
   
   var message = new Paho.MQTT.Message(hcsr_angle.toString());
   message.destinationName = "/command/servo3";
   publisher.send(message);

}
</script>
</head>
<body class="bg-dark">

   <!--  main start -->
   <div class="container-fluid bg-dark vh-100">
   
      <!-- Navbar start -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
         <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse"
            id="navbarNavDropdown">
            <ul class="navbar-nav">
               <li class="nav-item active"><a class="nav-link"
                  href="page1.do"> <svg class="bi bi-command" width="1em"
                        height="1em" viewBox="0 0 16 16" fill="currentColor"
                        xmlns="http://www.w3.org/2000/svg">
                       <path fill-rule="evenodd"
                           d="M2 3.5A1.5 1.5 0 0 0 3.5 5H5V3.5a1.5 1.5 0 1 0-3 0zM6 6V3.5A2.5 2.5 0 1 0 3.5 6H6zm8-2.5A1.5 1.5 0 0 1 12.5 5H11V3.5a1.5 1.5 0 0 1 3 0zM10 6V3.5A2.5 2.5 0 1 1 12.5 6H10zm-8 6.5A1.5 1.5 0 0 1 3.5 11H5v1.5a1.5 1.5 0 0 1-3 0zM6 10v2.5A2.5 2.5 0 1 1 3.5 10H6zm8 2.5a1.5 1.5 0 0 0-1.5-1.5H11v1.5a1.5 1.5 0 0 0 3 0zM10 10v2.5a2.5 2.5 0 1 0 2.5-2.5H10z" />
                       <path fill-rule="evenodd" d="M10 6H6v4h4V6zM5 5v6h6V5H5z" />
                     </svg>
               </a></li>
               <li class="nav-item"><a class="nav-link" href="page2.do">
                     <svg class="bi bi-graph-up" width="1em" height="1em"
                        viewBox="0 0 16 16" fill="currentColor"
                        xmlns="http://www.w3.org/2000/svg">
                       <path d="M0 0h1v16H0V0zm1 15h15v1H1v-1z" />
                       <path fill-rule="evenodd"
                           d="M14.39 4.312L10.041 9.75 7 6.707l-3.646 3.647-.708-.708L7 5.293 9.959 8.25l3.65-4.563.781.624z" />
                       <path fill-rule="evenodd"
                           d="M10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4h-3.5a.5.5 0 0 1-.5-.5z" />
                     </svg>
               </a></li>
               <li class="nav-item dropdown"><a
                  class="nav-link dropdown-toggle" href="#" id="navbardrop"
                  data-toggle="dropdown"> <svg class="bi bi-archive" width="1em"
                        height="1em" viewBox="0 0 16 16" fill="currentColor"
                        xmlns="http://www.w3.org/2000/svg">
                       <path fill-rule="evenodd"
                           d="M2 5v7.5c0 .864.642 1.5 1.357 1.5h9.286c.715 0 1.357-.636 1.357-1.5V5h1v7.5c0 1.345-1.021 2.5-2.357 2.5H3.357C2.021 15 1 13.845 1 12.5V5h1z" />
                       <path fill-rule="evenodd"
                           d="M5.5 7.5A.5.5 0 0 1 6 7h4a.5.5 0 0 1 0 1H6a.5.5 0 0 1-.5-.5zM15 2H1v2h14V2zM1 1a1 1 0 0 0-1 1v2a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H1z" />
                     </svg>
               </a>
                  <div class="dropdown-menu"
                     aria-labelledby="navbarDropdownMenuLink">
                     <a class="dropdown-item"
                        href="https://github.com/brotherwook/SensingRover">Sensing
                        Rover</a> <a class="dropdown-item"
                        href="https://github.com/brotherwook/WebBrowser">Web Browser</a>
                  </div></li>
            </ul>
         </div>
      </nav>
      <!-- Navbar end -->
      
      <!-- Main start -->
      <div class="row" style="height:94%">
      
         <div class="col-lg-4 h-100 bg-dark">
            <div class="row">
               <div class="col-3">
               </div>
               <div class="col-6 text-white">
                  <!-- Rounded switch -->
                  <p>Laser Emitter</p>
                  <svg class="bi bi-lightning-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M11.251.068a.5.5 0 0 1 .227.58L9.677 6.5H13a.5.5 0 0 1 .364.843l-8 8.5a.5.5 0 0 1-.842-.49L6.323 9.5H3a.5.5 0 0 1-.364-.843l8-8.5a.5.5 0 0 1 .615-.09z"/>
                  </svg>
                  <label style="margin-left: 10px;" class="switch">
                    <input type="checkbox" onclick="laser()">
                    <span class="slider round"></span>
                  </label>
                  <p id="p1">OFF</p>
                  <!-- Rounded switch -->
                  <p>Active Buzzer</p>
                  <svg class="bi bi-volume-up-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path d="M11.536 14.01A8.473 8.473 0 0 0 14.026 8a8.473 8.473 0 0 0-2.49-6.01l-.708.707A7.476 7.476 0 0 1 13.025 8c0 2.071-.84 3.946-2.197 5.303l.708.707z"/>
                    <path d="M10.121 12.596A6.48 6.48 0 0 0 12.025 8a6.48 6.48 0 0 0-1.904-4.596l-.707.707A5.483 5.483 0 0 1 11.025 8a5.483 5.483 0 0 1-1.61 3.89l.706.706z"/>
                    <path d="M8.707 11.182A4.486 4.486 0 0 0 10.025 8a4.486 4.486 0 0 0-1.318-3.182L8 5.525A3.489 3.489 0 0 1 9.025 8 3.49 3.49 0 0 1 8 10.475l.707.707z"/>
                    <path fill-rule="evenodd" d="M6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06z"/>
                  </svg>
                  <label style="margin-left: 10px;" class="switch">
                    <input id="buzzerbox" type="checkbox" onclick="buzzer('button')">
                    <span class="slider round"></span>
                  </label>
                  <p id="p2">OFF</p>
                  <!-- Rounded switch -->
                  <p class="text-white">Led Red</p>
                  <svg class="bi bi-brightness-alt-high-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill="red" fill-rule="evenodd" d="M4 11a4 4 0 1 1 8 0 .5.5 0 0 1-.5.5h-7A.5.5 0 0 1 4 11zm4-8a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3zm8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 11a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zM4.464 7.464a.5.5 0 0 1-.707 0L2.343 6.05a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707z"/>
                  </svg>
                  <label style="margin-left: 10px;" class="switch">
                    <input id="ledredbox" type="checkbox" onclick="ledred('button')">
                    <span class="slider round"></span>
                  </label>
                  <p id="p3">OFF</p>
                  <!-- Rounded switch -->
                  <p>Led Green</p>
                  <svg class="bi bi-brightness-alt-high-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill="green" fill-rule="evenodd" d="M4 11a4 4 0 1 1 8 0 .5.5 0 0 1-.5.5h-7A.5.5 0 0 1 4 11zm4-8a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3zm8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 11a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zM4.464 7.464a.5.5 0 0 1-.707 0L2.343 6.05a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707z"/>
                  </svg>
                  <label style="margin-left: 10px;" class="switch">
                    <input id="ledgreenbox" type="checkbox" onclick="ledgreen('button')">
                    <span class="slider round"></span>
                  </label>
                  <p id="p4">OFF</p>
                  <!-- Rounded switch -->
                  <p>Led Blue</p>
                  <svg class="bi bi-brightness-alt-high-fill" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill="blue" fill-rule="evenodd" d="M4 11a4 4 0 1 1 8 0 .5.5 0 0 1-.5.5h-7A.5.5 0 0 1 4 11zm4-8a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3zm8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 11a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zM4.464 7.464a.5.5 0 0 1-.707 0L2.343 6.05a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707z"/>
                  </svg>
                  <label style="margin-left: 10px;" class="switch">
                    <input id="ledbluebox" type="checkbox" onclick="ledblue('button')">
                    <span class="slider round"></span>
                  </label>
                  <p id="p5">OFF</p>
                  
                  <p>LCD</p>
                    <div class="form-group">
                      <input type="text" class="form-control" id="input1">
                    </div>
                    <div class="form-group">
                      <input type="text" class="form-control" id="input2">
                    </div>
                    <button onclick="LcdContentSend()" class="btn btn-primary">Submit</button>
                  <br>
                  <p></p>
                  <!-- Button trigger modal -->
                  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop" onclick="modal_open()">
                    Capture Image
                  </button>
                  
                  <!-- Modal -->
                  <div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                          </button>
                        </div>
                        <div class="modal-body">
                          <div class="container-fluid">
                            <div class="row">
                              <div class="col-6 border border-dark rounded-lg" style="postion:relative;height:100%">
                                 <div class="row" style="postion:relative;height:100%">
                                    <div class="col-11">
                                       <img id="cameraView2" style="width:95%; height:100%"/>
                                    </div>
                                    <div class="col-1">
                                       <%-- <img src="${pageContext.request.contextPath}/resource/img/rover_view.jpg" style="width:90%; height:60%"/> --%>
                                       <button type="button" class="btn btn-primary" style="position:absolute;right:0px;bottom:0px" onclick="image_capture()">Capture</button>
                                    </div>
                              </div>
                              </div>
                              <div class="col-6 border border-dark rounded-lg">
                                 <div class="row" style="postion:relative;height:100%">
                                    <div class="col-11">
                                       <img id="capture" style="width:95%; height:100%" alt="not captured"/>
                                    </div>
                                    <div class="col-1">
                                       <button type="button" class="btn btn-primary" style="position:absolute;right:0px;bottom:0px;width:84px;" onclick="image_save()">Save</button>
                                    </div>
                                 </div>
                              </div>
                            </div>
                            <br>
                            <div class="row">
                              <div class="col-3">
                                 <img id="show1" src="${pageContext.request.contextPath}/resource/img/rover_view.jpg" style="width:90%; height:90%"/>
                              </div>
                              <div class="col-3">
                                 <img id="show2" src="${pageContext.request.contextPath}/resource/img/rover_view.jpg" style="width:90%; height:90%"/>
                              </div>
                              <div class="col-3">
                                 <img id="show3" src="${pageContext.request.contextPath}/resource/img/rover_view.jpg" style="width:90%; height:90%"/>
                              </div>
                              <div class="col-3">
                                 <img id="show4" src="${pageContext.request.contextPath}/resource/img/rover_view.jpg" style="width:90%; height:90%"/>
                              </div>
                            </div>
                          </div>
                       </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                      </div>
                    </div>
                  </div>
               </div>
               <div class="col-3">
               </div>
            </div>
         </div>
         
         <div class="col-lg-4 h-100 bg-dark">
            <div class="h-50 border border-white rounded-lg p-0">
               <img id="cameraView" style="height:100%; width:100%"/>
            </div>
            <div>
               <br>
               <br>
            </div>
            <div class>
                <table class="table table-borderless text-center">
                   <thead>
                     <tr>
                       <th class="text-white" colspan="3">Camera</th>
                       <th class="text-white" colspan="3">Sensing Rover</th>
                       <th class="text-white" colspan="3">Ultrasonic Sensor</th>
                     </tr>
                   </thead>
                   <tbody>
                     <tr>
                       <td></td>
                       <td> <!-- 카메라 up -->
                          <a onclick="cameraMoveUp()">
                             <svg class="bi bi-chevron-up text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z"/>
                           </svg>
                          </a>
                       </td>
                       <td></td>
                       <td></td>
                       <td> <!-- DCMotor forward -->
                          <a onclick="forward()">
                             <svg class="bi bi-arrow-up text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V4a.5.5 0 0 1 .5-.5z"/>
                             <path fill-rule="evenodd" d="M7.646 2.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8 3.707 5.354 6.354a.5.5 0 1 1-.708-.708l3-3z"/>
                           </svg>
                          </a>
                       </td>
                       <td></td>
                       <td></td>
                       <td></td>
                       <td></td>
                     </tr>
                     <tr>
                       <td> <!-- 카메라 left -->
                          <a onclick="cameraMoveLeft()">
                             <svg class="bi bi-chevron-left text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- 카메라 정렬 -->
                          <a onclick="cameraMoveCenter()">
                             <svg class="bi bi-plus-circle text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
                             <path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
                             <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- 카메라 right -->
                          <a onclick="cameraMoveRight()">
                             <svg class="bi bi-chevron-right text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- Front Tire left -->
                          <a onclick="keyPressOrder(37)">
                             <svg class="bi bi-arrow-left text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M5.854 4.646a.5.5 0 0 1 0 .708L3.207 8l2.647 2.646a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 0 1 .708 0z"/>
                             <path fill-rule="evenodd" d="M2.5 8a.5.5 0 0 1 .5-.5h10.5a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- DCMotor Stop -->
                          <a onclick="stop()">
                             <svg class="bi bi-x-circle text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                             <path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708-.708l7-7a.5.5 0 0 1 .708 0z"/>
                             <path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 0 0 0 .708l7 7a.5.5 0 0 0 .708-.708l-7-7a.5.5 0 0 0-.708 0z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- Front Tire Right -->
                          <a onclick="keyPressOrder(39)">
                             <svg class="bi bi-arrow-right text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M10.146 4.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 8l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
                             <path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5H13a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 8z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- Ultrasonic Left -->
                          <a onclick="hcsrMotor_down('left')">
                             <svg class="bi bi-chevron-left text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- Ultrasonic 정렬 -->
                          <a onclick="hcsrMotor_down('middle')">
                             <svg class="bi bi-plus-circle text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
                             <path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
                             <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                           </svg>
                          </a>
                       </td>
                       <td> <!-- Ultrasonic Right -->
                          <a onclick="hcsrMotor_down('right')">
                             <svg class="bi bi-chevron-right text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
                           </svg>
                          </a>
                       </td>
                     </tr>
                     <tr>
                       <td></td>
                       <td> <!-- 카메라 down -->
                          <a onclick="cameraMoveDown()">
                             <svg class="bi bi-chevron-down text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                           </svg>
                          </a>
                       </td>
                       <td></td>
                       <td></td>
                       <td> <!-- DCMotor Backward -->
                          <a onclick="backward()">
                             <svg class="bi bi-arrow-down text-white" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                             <path fill-rule="evenodd" d="M4.646 9.646a.5.5 0 0 1 .708 0L8 12.293l2.646-2.647a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 0-.708z"/>
                             <path fill-rule="evenodd" d="M8 2.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V3a.5.5 0 0 1 .5-.5z"/>
                           </svg>
                          </a>
                       </td>
                       <td></td>
                       <td></td>
                       <td></td>
                       <td></td>
                     </tr>
                   </tbody>
                 </table>
            </div>
         </div>
         
         <div class="col-lg-4 h-100 bg-dark">
         <br>
         <br>
         <br>
         <br>
            <div>
                     <figure class="highcharts-figure">
             <div id="speed" class="chart-container"></div>
             <div id="direction" class="chart-container"></div>
         </figure>
            </div>
            
            <div>
                     <figure class="highcharts-figure">
             <div id="camera_vertical" class="chart-container"></div>
             <div id="camera_horizontal" class="chart-container"></div>
         </figure>
            </div>
            
            <div>
                     <figure class="highcharts-figure">
             <div id="ultrasonic_direction" class="chart-container"></div>
             <div id="ultrasonic" class="chart-container"></div>
         </figure>
            </div>
         </div>
         
      </div>
      <!-- Main end -->
      
   </div>
   <!-- main end -->
</body>
</html>