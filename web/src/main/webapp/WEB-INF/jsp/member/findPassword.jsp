<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Password</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/main.css" />
<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resource/css/noscript.css" />
</noscript>
</head>
<body>
	<div class="container-fluid vh-100 vw-100">
		<div style="height: 20%" class="row">
			<div class="col-45"></div>
			<div class="col-3"></div>
			<div class="col-45"></div>
		</div>
		<div style="height: 80%" class="row">
			<div class="col-45"></div>
			<div id="logoDiv" class="col-3">
				<center>
					<h2 style="margin-top:23.4px;">
						<a href="main.do" id="logo">Autonomous Driving</a>
					</h2>
				</center>
				<form:form method="post" action="findPassword.do"
					modelAttribute="member">
					<div class="md-form mb-1">
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-name">
							<i class="fas fa-user prefix grey-text"></i>아이디
						</label>
						<form:input path="mid" style="margin-bottom: 20px;" name="mid"
							type="text" id="orangeForm-id" class="form-control validate" />
						<form:errors path="mid" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form mb-1">
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-name">
							<i class="fas fa-user prefix grey-text"></i>이름
						</label>
						<form:input path="mname" style="margin-bottom: 20px;" name="mname"
							type="text" id="orangeForm-name" class="form-control validate" />
						<form:errors path="mname" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form mb-1">
						<label
							style="margin-bottom: 0px; font-size: 20px; margin-top: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-email">
							<i class="fas fa-envelope prefix grey-text"></i>이메일
						</label>
						<form:input path="memail" style="margin-bottom: 0px;"
							name="memail" type="email" id="orangeForm-email"
							class="form-control validate" />
						<a type="button"
							style="float: right; margin-bottom: 20px; border: none; font-size: 15px;"
							onclick="fun1()">인증하기</a>
						<form:errors path="memail" style="color:red; font-size:1.0rem" /><br/>
					</div>
					<div>
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-conf">인증번호</label>
						<input style="margin-bottom: 0px;" name="mkey" type="text"
							id="orangeForm-email2" class="form-control validate"> <a
							type="button"
							style="float: right; margin-bottom: 20px; border: none; font-size: 15px;"
							onclick="fun2()">인증</a>
					</div>

					<div class="md-form mb-1">
						<button id="next" disabled=true style="width: 100%;"
							class="button primary fit">확인</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/jquery.scrollex.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/jquery.scrolly.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/browser.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/breakpoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/util.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/main.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/passemail.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/signup.js"></script>

</body>
</html>