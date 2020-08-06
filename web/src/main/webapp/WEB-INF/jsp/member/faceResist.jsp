<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Face authentication</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/faceResist.css">
</head>
<body>

	<div id="wrap" class="container-fulid vh-100">
		<header class="row">
			<div class="col-3"></div>
			<div id="notice" class="col-6">
			얼굴을 네모칸 중앙에 맞춰 주세요.
			</div>
			<div class="col-3"></div>
		</header>
		<section class="row">
			<div  class="col-3"></div>
			<div id="angle" class="col-6"></div>
			<div class="col-3"></div>
		</section>
		<footer class="row">
			<div class="col-3"></div>
			<div id="resiterButtonDiv" class="col-6">
			<button style="font-size: 1.0rem;"type="button" class="btn btn-primary" >사진 등록</button>
			</div>
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
</html>