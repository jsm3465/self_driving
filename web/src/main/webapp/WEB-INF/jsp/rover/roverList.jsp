<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<!-- bootswatch slate theme -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/roverList.css">
</head>

<body>
	<div class="fluid-container vh-100">
		<header class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<h1>Control Center</h1>
			</div>
			<div id="userIdDiv" class="col-3">
				<a href="${pageContext.request.contextPath}/member/memberInformationForm.do">${sessionMid}</a>
			</div>
		</header>
		<section class="row">
			<div id="roverList" class="col-4">
				<h3>Select Car</h3>
				<c:forEach var="rover" items="${roverList}">
				<form method="post" action="selectMode.do">
					<input type="hidden" name="rname" value="${rover.rname}"/>
					<button id="${rover.rname}" type="submit"
						class="btn btn-outline-info btn-block">${rover.rname}
						<span class="badge badge-secondary">${rover.ruser}</span>
					</button>
				</form>
				</c:forEach>
				<form id="resisterRoverForm" action="resisterRoverForm.do"></form>
				<button id="resisterRoverFormButton" type="submit"
					class="btn btn-outline-info btn-block" form="resisterRoverForm">+</button>
			</div>
			<div class="col-8">
				<h3>Map</h3>
				<div class="h-75">
					<canvas id="myCanvas" width="500" height="500"
						style="border: 1px solid #000000;"></canvas>
				</div>
			</div>
		</section>
		<footer class="row"> </footer>
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