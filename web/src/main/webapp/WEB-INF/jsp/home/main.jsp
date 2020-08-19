<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<title>Autonomous driving</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/mainPage.css">
</head>

<body>
	<div class="container-fluid vh-100">
		<div class="row">
			<div class="col-md-3" id="logo">
				<a href="main.do">Autonomous Driving</a>
			</div>
			<div class="col-md-7"></div>
			<div class="col-md-2">
				<c:if test="${sessionMid == null}">
					<a href="${pageContext.request.contextPath}/member/signupForm.do"
						class="signup">회원가입</a>
					<a href="${pageContext.request.contextPath}/member/signinForm.do"
						class="signin">로그인</a>
				</c:if>
				<c:if test="${sessionMid != null}">
					<a href="${pageContext.request.contextPath}/member/signout.do"
						class="signout">로그아웃</a>
				</c:if>
			</div>
		</div>
		<div>
			<ul>
				<li><a href="cctvScreen.do">cctvScreen.do</a></li>
				<li><a href="temp.do">temp.do</a></li>
				<li><a href="/project/rover/roverHud.do">roverHud.do</a></li>

			</ul>
		</div>
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
