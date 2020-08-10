<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>resisterRoverForm</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">

<!-- bootswatch slate theme -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/resisterRoverForm.css">

</head>
<body>
	<div class="container-fluid vh-100">
		<header class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<h1>Register</h1>
			</div>
			<div class="col-3"></div>
		</header>
		<section class="row">
			<div class="col-5 align-items-center justify-content-center">
				<form method="post" action="resisterRover.do">
					<div class="form-group">
						<label for="inputName">Name</label> 
						<input type="text" id="inputName" class="form-control" name="rname">
					</div>
					<div class="form-group">
						<label for="inputType">Type</label>
						<select id="inputType" class="form-control" name="rtype">
							<option selected>Choose</option>
							<option>jetRacer</option>
							<option>sensingRover</option>
						</select>
					</div>
					<div class="form-group">
						<label for="inputIP">IP address</label> 
						<input type="text" id="inputIP" class="form-control" name="rip">
					</div>
					<button type="submit" class="btn btn-primary">Register</button>
				</form>
			</div>
			<div class="col-7"></div>
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