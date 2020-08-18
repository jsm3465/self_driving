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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<!-- bootswatch slate theme -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/aiMode.css">


</head>
<body>
	<div class="container-fluid vh-100">
		<header class="row">
			<div id="logo" class="col-3">
				<a href="main.do">Autonomous Driving</a>
			</div>
			<div id="modeName" class="col-6">AI MODE</div>
			<div id="userName" class="col-3">
				${rover.ruser}</div>
		</header>
		<section class="row">
			<div class="col-4">
				<div class="row" id="speedArea">
					<div class="col-4"></div>
					<div class="col-4"></div>
					<div class="col-4"></div>
				</div>
				<div class="row" id="cameraArea">
					<input id="rname" type="hidden" value="/${rover.rname}"/>
					<img id="cameraView" />
				</div>
			</div>
			<div class="col-8" id="mapArea"></div>
		</section>
		<footer class="row">
			<div class="col-3"></div>
			<div class="col-3"></div>
			<div class="col-3"></div>
			<div class="col-3"></div>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
		type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/resource/js/aiMode.js"></script>

</body>
</html>