<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Password</title>
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
	href="${pageContext.request.contextPath}/resource/css/signIn.css">
</head>
<body>
	<div class="container-fluid vh-100 vw-100">
		<div style="height: 30%" class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4" id="logobox">
				<a href="main.do" id="logo">Autonomous Driving</a>
			</div>
			<div class="col-md-4"></div>
		</div>
		<div style="height: 60%" class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<form:form method="post" action="findPassword.do"
					modelAttribute="member">
					<div class="md-form mb-3">
						<i class="fas fa-user prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-name">아이디</label>
						<form:input path="mid" style="margin-bottom: 20px;" name="mid"
							type="text" id="orangeForm-id" class="form-control validate" />
						<form:errors path="mid" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form mb-3">
						<i class="fas fa-user prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-name">이름</label>
						<form:input path="mname" style="margin-bottom: 20px;" name="mname"
							type="text" id="orangeForm-name" class="form-control validate" />
						<form:errors path="mname" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form mb-3">
						<i class="fas fa-envelope prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px; margin-top: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-email">이메일</label>
						<form:input path="memail" style="margin-bottom: 20px;"
							name="memail" type="email" id="orangeForm-email"
							class="form-control validate" />
						<a type="button"
							style="float: right; margin-bottom: 20px; border: none;"
							onclick="fun1()">인증하기</a>
						<form:errors path="memail" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form pb-3">
						<i class="fas fa-envelope prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-conf">인증번호</label> <input
							style="margin-bottom: 20px;" name="mkey" type="text"
							id="orangeForm-email2" class="form-control validate"> <a
							type="button"
							style="float: right; margin-bottom: 20px; border: none;"
							onclick="fun2()">인증</a>
					</div>

					<div class="md-form pb-3">
						<a href="confirmPassword.do"><button
								style="background-color: #AAAAAA; color: white; width: 100%; margin-top: 30px;"
								class="btn btn-deep-orange" id="next">확인</button></a>
					</div>
				</form:form>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/idemail.js"></script>
	<script>
		$(function() {
			$("#next").hide();
		});
	</script>
</body>
</html>