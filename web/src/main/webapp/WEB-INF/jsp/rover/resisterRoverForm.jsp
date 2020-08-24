<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>resisterRoverForm</title>
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
	<div class="container-fluid vw-100 vh-100">
		<div style="height: 20%" class="row">
			<div class="col-45"></div>
			<div class="col-3"></div>
			<div class="col-45"></div>
		</div>
		<div style="height: 80%" class="row">
			<div class="col-45"></div>
			<div id="logoDiv" class="col-3">
				<center>
					<h2>
						<a href="../home/main.do" id="logo">Autonomous Driving</a>
					</h2>
				</center>
				<form method="post" action="resisterRover.do">
					<div class="md-form mb-1">
						<label
							style="margin-top: 3%; margin-bottom: 0px; font-size: 20px;"
							for="inputName">Name</label> <input type="text" id="inputName"
							class="form-control" name="rname">
					</div>
					<div class="md-form mb-1">
						<label
							style="margin-top: 3%; margin-bottom: 0px; font-size: 20px;for="inputType">Type</label>
						<select id="inputType" class="form-control" name="rtype">
							<option selected>Choose</option>
							<option>jetRacer</option>
							<option>sensingRover</option>
						</select>
					</div>
					<div class="md-form mb-1">
						<label
							style="margin-top: 3%; margin-bottom: 0px; font-size: 20px;"
							for="inputIP">IP address</label> <input type="text" id="inputIP"
							class="form-control" name="rip">
					</div>
					<div style="margin-top: 10%;">
						<button style="width: 100%;" type="submit"
							class="button primary fit">Register</button>
					</div>
				</form>
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
</body>
</html>