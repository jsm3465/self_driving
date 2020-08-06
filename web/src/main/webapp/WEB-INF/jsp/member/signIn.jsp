<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/signIn.css">
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
					<form method="post" action="signin.do">
			        <div class="md-form mb-3">
			          <label style="font-size: 1.2rem;" data-error="wrong" data-success="right" for="Form-email1">아이디</label>
			          <input
						style="margin-bottom: 20px;" name="mid"
						type="text" id="orangeForm-id" class="form-control validate">
			        </div>
			
			        <div class="md-form pb-3">
			          <label style="font-size: 1.2rem;" data-error="wrong" data-success="right" for="Form-pass1">비밀번호</label>
			          <input type="password" id="Form-pass1" class="form-control validate" name="mpassword">
			          <p style="font-size: 1.0rem;" class="font-small blue-text d-flex justify-content-end"><a href="${pageContext.request.contextPath}/member/findIdForm.do">아이디 찾기</a></p>
		              <p style="font-size: 1.0rem;" class="font-small blue-text d-flex justify-content-end"><a href="${pageContext.request.contextPath}/member/findPasswordForm.do">비밀번호 찾기</a></p>
			        </div>
			        <div class="text-center mb-3">
			          <a href="${pageContext.request.contextPath}/member/faceAuthenticationForm.do"><button style="color: white;background-color:#AAAAAA; ;"class="btn blue-gradient btn-block btn-rounded z-depth-1a">로그인</button></a>
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