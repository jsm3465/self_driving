<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Information</title>
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
	href="${pageContext.request.contextPath}/resource/css/findId.css">
</head>
<body>
	<div class="modal fade" id="changePassword" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">비밀번호 변경</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<i class="fas fa-lock prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-pass">기존 비밀번호</label> <input
						style="margin-bottom: 20px;" name="baseMpassword" type="password"
						id="orangeForm-pass2" class="form-control validate" /> </br> <i
						class="fas fa-lock prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-pass">새 비밀번호</label> <input
						style="margin-bottom: 20px;" name="mpasswordNew" type="password"
						id="orangeForm-pass3" class="form-control validate" />
				</div>
				<div class="modal-footer">
					<button id="close" type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>

					<button onclick="fun3();" type="button" class="btn btn-primary">변경</button>
				</div>
			</div>
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
	<script
		src="${pageContext.request.contextPath}/resource/js/memberInformation.js"></script>
</body>
</html>