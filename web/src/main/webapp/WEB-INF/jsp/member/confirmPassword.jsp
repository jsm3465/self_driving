<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Confirm Password</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/findId.css">
	</head>
	<body>
		<div class="container-fluid vh-100 vw-100">
			<div style="height: 20%"class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4" id="logobox">
					<a href="main.do" id="logo">Autonomous Driving</a>
				</div>
				<div class="col-md-4"></div>
			</div>
			<div style="height: 60%"class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="jumbotron">
						<div class="row">
						  <a style="font-size: 78px;">귀하의 비밀번호는</a>
						</div>
						<div class="text-center">
						  <a style="font-size: 78px; color: #FFFFFF;">${message}</a>
						</div>
						<div class="text-right">  
						  <a style="font-size: 78px;">입니다.</a>
						</div>
						<div class="text-right">
						  <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/	home/main.do" role="button">홈으로</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	</body>
</html>