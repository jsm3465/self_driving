<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
	</head>
	<body>
		<div class="fluid-container vh-100">
			<header class="row">
				<div class="col-3">
				</div>
				<div class="col-6">
					<h1>Control Center</h1>
				</div>
				<div class="col-3">
				</div>
			</header>
			<section class="row">
				<div class="col-4">
					<h3>Select Car</h3>
					<button type="button" class="btn btn-outline-info btn-block">Car 1 or Register 
						<span class="badge badge-secondary">운행중 by name1 or 사용 가능</span></button>
					<button type="button" class="btn btn-outline-info btn-block">Car 2 or Register 
						<span class="badge badge-secondary">운행중 by name1 or 사용 가능</span></button>
					<button type="button" class="btn btn-outline-info btn-block">Car 3 or Register 
						<span class="badge badge-secondary">운행중 by name1 or 사용 가능</span></button>
				</div>
				<div class="col-8">
					<h3>Map</h3>
					<div class="h-75">
						<canvas id="myCanvas" width="500" height="500" style="border:1px solid #000000;"></canvas>				
					</div>
				</div>
			</section>
			<footer class="row">
			</footer>
		</div>
		
		<script>
	        window.onload = function(e) {
	        	var c = document.getElementById("myCanvas");
	        	var ctx = c.getContext("2d");

	        	ctx.beginPath();
	        	ctx.strokeStyle = "white"; // Green path
	        	ctx.moveTo(50, 50);
	        	ctx.lineTo(400, 50);
	        	
	        	ctx.arcTo(450, 50, 450, 100, 50);
	        	
	        	ctx.lineTo(450, 400);
	        	
	        	ctx.arcTo(450, 450, 400, 450, 50);
	        	
	        	ctx.lineTo(150, 450);
	        	
	        	ctx.arcTo(150, 400, 100, 400, 50);
	        	
	        	ctx.arcTo(50, 400, 50, 350, 50);
	        	
	        	ctx.stroke(); // Draw it
	        }
		</script>
		
		<!-- <script>
	        window.onload = function(e) {
	        	var canvas = document.getElementById("myCanvas");
	        	canvas.width = canvas.parentNode.clientWidth;
	        	canvas.height = canvas.parentNode.clientHeight;
				var ctx = canvas.getContext("2d");
				ctx.fillStyle = "yellow";
				ctx.fillRect(0, 0, canvas.width/2, canvas.height/2);
	        }
		</script> -->
		
	</body>
</html>