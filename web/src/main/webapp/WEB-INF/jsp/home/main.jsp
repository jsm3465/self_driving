<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../member/signUp.jsp" />
<jsp:include page="../member/signIn.jsp" />
<jsp:include page="../member/findId.jsp" />
<jsp:include page="../member/findPassword.jsp" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
		<title>Autonomous driving</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mainPage.css">
	</head>

	<body>
		<div class="container-fluid vh-100">
			<div class="row">
				<div class="col-md-3">
					<h1>Autonomous Driving</h1>
				</div>
				<div class="col-md-7">
				</div>
				<div class="col-md-2">
					<a class="signup" data-toggle="modal" data-target="#modalRegisterForm">회원가입</a>
					<a class="signin" data-toggle="modal" data-target="#elegantModalForm">로그인</a>
				</div>
			</div>
			<div>
				<ul>
					<li><a href="manualDriving.do">Manual Driving</a></li>
					<li><a href="carInfo.do">Car Info</a></li>
					<li><a href="navi.do">navi</a></li>
				</ul>
			</div>
		</div>
		
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	</body>
</html>
