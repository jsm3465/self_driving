<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css" />
		<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/noscript.css"/></noscript>
</head>
<body>
	<div class="container-fluid vh-100 vw-100">
		<div style="height: 30%" class="row">
				<div class="col-md-4"></div>
				<div  class="col-md-4">
					
					<h2><a id="logo" href="main.do">Autonomous Driving</a></h2>
					
				</div>
				<div class="col-md-4"></div>
		</div>
		<div style="height: 60%" class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<form:form method="post" action="signin.do" modelAttribute="member">
					
					
		
					<div class="md-form mb-3">
						<label style="font-size: 1.2rem;" data-error="wrong"
							data-success="right" for="Form-id1">아이디</label>
						<form:input path="mid" name="mid" type="text" id="orangeForm-id"
							class="form-control validate" />
						<form:errors path="mid" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form pb-3">
						<label style="font-size: 1.2rem;" data-error="wrong"
							data-success="right" for="Form-pass1">비밀번호</label>
						<form:input path="mpassword" type="password" id="Form-pass1"
							class="form-control validate" name="mpassword" />
						<form:errors path="mpassword" style="color:red; font-size:1.0rem" />
						<p style="font-size: 1.0rem;"
							class="font-small blue-text d-flex justify-content-end">
							<a href="${pageContext.request.contextPath}/member/findIdForm.do">아이디
								찾기</a>
						</p>
						<p style="font-size: 1.0rem;"
							class="font-small blue-text d-flex justify-content-end">
							<a
								href="${pageContext.request.contextPath}/member/findPasswordForm.do">비밀번호
								찾기</a>
						</p>
					</div>
					<div class="text-center mb-3">
						<button style="color: white; background-color: #AAAAAA;"
							class="btn blue-gradient btn-block btn-rounded z-depth-1a">로그인</button>
					</div>
				</form:form>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>

	<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/jquery.scrollex.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/main.js"></script>
			<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
</body>
</html>