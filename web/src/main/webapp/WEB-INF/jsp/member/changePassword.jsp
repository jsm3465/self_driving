<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
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
				<form method="post" action="changePassword.do">
					<div class="modal-body">

						<i class="fas fa-lock prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-pass">기존 비밀번호</label> <input
							style="margin-bottom: 20px;" name="mpassword" type="password"
							id="orangeForm-pass" class="form-control validate"> <i
							class="fas fa-lock prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-pass">새 비밀번호</label> <input
							style="margin-bottom: 20px;" name="mpasswordNew" type="password"
							id="orangeForm-pass" class="form-control validate">

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>

						<button type="submit" class="btn btn-primary">변경</button>
					</div>
				</form>
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
</body>
</html>