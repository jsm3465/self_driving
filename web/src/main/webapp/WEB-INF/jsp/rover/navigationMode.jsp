<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device=width, inital-scale=1">
<title>Manual driving page</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/navi.css">

</head>
<body>
	<div id="wrap" class="container-fulid vh-100">
		<header class="row">
			<div id="logo" class="col-3">
				<a href="main.do">Autonomous Driving</a>
			</div>
			<div id="modeName" class="col-6">NAVIGATION MODE</div>
			<div id="userName" class="col-3">${rover.ruser}</div>
		</header>
		<section class="row">
			<div id="inputForm" class="col-4">

				<div class="form-group">
					<label for="startPosition">start</label> <input
						type="text" class="form-control" id="startPosition"
						placeholder="current posision: ...">
				</div>
				
				<div class="form-group">
					<label for="endPosition">destination</label> <input
						type="text" class="form-control" id="endPosition"
						placeholder="목적지 좌표">
				</div>
				<!-- invalid / valid input reference 
				<div class="form-group has-success">
					<label class="form-control-label" for="inputSuccess1">
					start</label> <input type="text" value="현재 위치: ..."
						class="form-control is-valid" id="inputValid">
					<div class="valid-feedback">Success! You've done it.</div>
				</div>

				<div class="form-group has-danger">
					<label class="form-control-label" for="inputDanger1">
					destination</label> <input type="text" value="wrong value"
						class="form-control is-invalid" id="inputInvalid">
					<div class="invalid-feedback">Sorry, that username's taken.
						Try another?</div>
				</div>
				-->
				 <button type="submit" class="btn btn-primary">START</button>

			</div>
			<div id="map" class="col-md-8"></div>
		</section>
		<footer class="row">
			<div class="col-3">Speed</div>
			<div class="col-3">Lux</div>
			<div class="col-3">Temp</div>
			<div class="col-3">배터리 잔량</div>
		</footer>
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