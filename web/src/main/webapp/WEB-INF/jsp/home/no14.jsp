<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>No. 14</title>
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
				border: solid 1px;
			}
			header {
				height: 10%;
			}
			section {
				height: 85%;
			}
			footer {
				height: 5%;
			}
		</style>
	</head>
	<body>
		<div class="container-fluid vh-100">
			<header class="row">
				<div class="col-3">
				</div>
				<div class="col-6">
					<h1>Register</h1>
				</div>
				<div class="col-3">
				</div>
			</header>
			<section class="row">
				<div class="col-5 align-items-center justify-content-center">
					<form>
						<div class="form-group">
					        <label for="inputType">Type</label>
					        <select id="inputType" class="form-control">
					          <option selected>Choose</option>
					          <option>Car Type 1</option>
					          <option>Car Type 2</option>
					          <option>Car Type 3</option>
					        </select>
					    </div>
						<div class="form-group">
						    <label for="inputIP">IP address</label>
						    <input type="text" class="form-control" id="inputIP">
					    </div>
					    <div class="form-group">
						    <label for="inputPort">Port</label>
						    <input type="text" class="form-control" id="inputPort">
					    </div>
					    <div class="form-group">
						    <label for="inputName">Name</label>
						    <input type="text" class="form-control" id="inputName">
					    </div>
					    <button type="submit" class="btn btn-primary">Register</button>
					</form>
				</div>
				<div class="col-7">
				</div>
			</section>
			<footer class="row">
			</footer>
		</div>
	</body>
</html>