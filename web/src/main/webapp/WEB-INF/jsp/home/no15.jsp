<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>No. 15</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<!-- bootswatch slate theme -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
		<!-- 나중에 .css 파일로 옮길것 -->
		<!-- border는 나중에 지울것 -->
		<style> 
			* { 
				border:solid 1px;
			}
			header {
				height:10%;
			}
			section {
				height:75%;
			}
			footer {
				height:15%;
			}
			.card {
				width:60%;
				height:60%;
			}
		</style>
	</head>
	<body>
		<div class="container-fluid vh-100">
			<header class="row">
				<div class="col-3">
				</div>
				<div class="col-6">
					<h1>Car 1</h1>
				</div>
				<div class="col-3">
				</div>
			</header>
			<section class="row">
				<div class="col-4 d-flex align-items-center justify-content-center">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">AI Mode</h5>
							<p class="card-text">Car drives automatically without manipulation.</p>
							<a href="#" class="btn btn-primary">Activate</a>
						</div>
					</div>
				</div>
				<div class="col-4 d-flex align-items-center justify-content-center">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Manual Mode</h5>
							<p class="card-text">Full control of car by manipulation.</p>
							<a href="#" class="btn btn-primary">Activate</a>
						</div>
					</div>
				</div>
				<div class="col-4 d-flex align-items-center justify-content-center">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Navigation Mode</h5>
							<p class="card-text">Car drives automatically from and to destination set.</p>
							<a href="#" class="btn btn-primary">Activate</a>
						</div>
					</div>
				</div>
			</section>
			<footer class="row">
			</footer>
		</div>
	</body>
</html>