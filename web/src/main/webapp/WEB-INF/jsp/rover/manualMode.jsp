<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device=width, inital-scale=1">
<title>Manual driving page</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/manualMode.css">

</head>
<body>
	<div id="wrap" class="container-fulid vh-100">
		<header class="row">
			<div id ="logo" class="col-3"><a href="main.do">Autonomous Driving</a></div>
			<div id="modeName"class="col-6">MANUAL MODE</div>
			<div id="userName" class="col-3">
				${rover.ruser} 
		 		<button id="aiModeButton" type="button" class="btn btn-secondary" >AI MODE</button>
			</div>
		</header>
		<section class="row">
			<div id="carInfo" class="col-4">
				<div id="carInfo1" class="row">
					<div class="col-4"></div>
					<div class="col-4"></div>
					<div class="col-4"></div>
				</div>
				<div id="cam"></div>
			</div>
			<div id="map" class="col-md-8"></div>
		</section>
		<footer class="row">
			<div class="col-3"></div>
			<div class="col-3"></div>
			<div class="col-3"></div>
			
			<!-- 방향키 버튼 -->
			<div class="col-3">
				<div class="row" style="height: 55%">
					<div class="col-4"></div>
					<div id="directionUpButtonDiv" class="col-4">
						<button id="upButton" type="button" class="btn btn-secondary">▲</button>
					</div>
					<div class="col-4"></div>
				</div>
				<div id="directionButtonDiv" class="row" style="height: 45%">
					
						<button id="leftButton" type="button" class="btn btn-secondary">◀</button>
					
						<button id="downButton" type="button" class="btn btn-secondary">▼</button>
					
						<button id="lightButton" type="button" class="btn btn-secondary">▶</button>
				</div>
			</div>
		</footer>
	</div>

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