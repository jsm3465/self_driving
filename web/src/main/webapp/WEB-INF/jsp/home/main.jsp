<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../member/sign_up.jsp" />
<jsp:include page="../member/sign_in.jsp" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Autonomous Driving</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<!-- 부트스트랩 slate -->
		<link rel="stylesheet" href="${pagecontext.request.contextpath}/resource/css/bootstrap.min.css">
		<!-- width = 장치 화면 너비에 따라 페이지 너비 설정, initial-scale = 페이지가 처음 브라우저에 의해로드 된 초기 줌 레벨 -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- 폰트 -->
		<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<!-- 메인페이지 css -->
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
		</div>
	</body>
</html>