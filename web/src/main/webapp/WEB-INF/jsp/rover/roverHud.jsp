<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI MODE</title>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<%-- <link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css"> --%>
   <script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<!-- bootswatch slate theme -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resource/css/roverHud.css">
<!-- width = 장치 화면 너비에 따라 페이지 너비 설정, initial-scale = 페이지가 처음 브라우저에 의해로드 된 초기 줌 레벨 -->
      <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
   <div class="container-fluid vh-100">
      <header class="row">
         <div id="logo" class="col-3">
            <a href="../home/hudTomain.do?rname=${rover.rname}">Autonomous Driving</a>
         </div>
         <div id="modeName" class="col-6">${rover.rname}</div>
         <div id="userName" class="col-3">
            ${rover.ruser}</div>
      </header>
      <section class="row">
            <input id="rname" type="hidden" value="/${rover.rname}"/>
            <canvas id="cameraLayer"></canvas>
            <canvas id="shapeLayer"></canvas>
            <canvas id="locationLayer"></canvas>
            <canvas id="mapLayer"></canvas>
            <canvas id="carLayer"></canvas>
            <canvas id="objectLayer"></canvas>
            
            <div id="buttonGroup" class="btn-group" role="group" aria-label="Basic example">
               <button type="button" class="btn btn-secondary" checked>AI Mode</button>
               <button type="button" class="btn btn-secondary">Manual Mode</button>
               <button type="button" class="btn btn-secondary">Navigation Mode</button>
            </div>
            
            <div id="navUI">
               <form>
                 <div class="form-group">
                   <label for="startPosition">Start Position</label>
                   <select class="form-control" id="startPosition" onchange="drawRoute()">
                     <option selected disabled>출발점 선택</option>
                     <option>A</option>
                     <option>B</option>
                     <option>C</option>
                     <option>D</option>
                     <option>E</option>
                     <option>F</option>
                     <option>H</option>
                     <option>I</option>
                     <option>J</option>
                     <option>K</option>
                     <option>M</option>
                     <option>N</option>
                     <option>P</option>
                     <option>S</option>
                     <option>T</option>
                   </select>
                 </div>
                 <div class="form-group">
                   <label for="endPosition">End Position</label>
                   <select class="form-control" id="endPosition" onchange="drawRoute()">
                     <option selected disabled>도착점 선택</option>
                     <option>A</option>
                     <option>B</option>
                     <option>C</option>
                     <option>D</option>
                     <option>E</option>
                     <option>F</option>
                     <option>H</option>
                     <option>I</option>
                     <option>J</option>
                     <option>K</option>
                     <option>M</option>
                     <option>N</option>
                     <option>P</option>
                     <option>S</option>
                     <option>T</option>
                   </select>
                 </div>
               </form>
               <canvas id="navMapLayer"></canvas>
            </div>
      </section>
   </div>

<!--    <script -->
<%--       src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script> --%>
   <script
        src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
   <script
      src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
   <script
      src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
   <script
      src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
   <script
      src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
      type="text/javascript"></script>
   <script src="${pageContext.request.contextPath}/resource/js/roverHud.js"></script>
</body>
</html>