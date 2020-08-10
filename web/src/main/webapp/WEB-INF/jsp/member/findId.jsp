<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Find Id</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/findId.css">
	</head>
	<body>
		<div class="container-fluid vh-100 vw-100">
			<div style="height: 30%"class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4" id="logobox">
					<a href="main.do" id="logo">Autonomous Driving</a>
				</div>
				<div class="col-md-4"></div>
			</div>
			<div style="height: 60%"class="row">
				
				<div class="col-md-4"></div>
				<div class="col-md-4">
				<form method="post" action="findId.do">
				<div class="md-form mb-3">
					<i class="fas fa-user prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-name">이름</label> <input
						name="mname"
						type="text" id="orangeForm-name" class="form-control validate">
				</div>
				
				<div class="md-form mb-3">
					<i class="fas fa-envelope prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-email">이메일</label> <input
						name="memail"
						type="email" id="orangeForm-email" class="form-control validate">
					<button style="float: right; margin-top: 3px; border: none;">인증하기</button>
				</div>
				
				<div class="md-form pb-3">
					<i class="fas fa-envelope prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-conf">인증번호</label> <input
						type="text" id="orangeForm-email" class="form-control validate">
					<button style="float: right; margin-top: 3px; border: none;">인증</button>
				</div>
				
				<div class="md-form pb-3">
				<button
						style="background-color: #AAAAAA; color: white; width: 100%; margin-top: 30px;"
						class="btn btn-deep-orange">확인</button>
			</div>
			</form>
			</div>
				</div>
				<div class="col-md-4"></div>
			</div>
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	</body>
</html>