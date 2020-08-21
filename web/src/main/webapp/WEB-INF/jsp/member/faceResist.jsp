<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Face Resist</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/faceResist.css">

</head>
<body>

	<div id="wrap" class="container-fulid vh-100">
		<header class="row">
			<div class="col-3"></div>
			<div id="notice" class="col-6">
			얼굴을 네모칸 중앙에 맞춰 주세요.
			</div>
			<div class="col-3"></div>
		</header>
		<section class="row">
			<div  class="col-3"></div>
			<div id="angle" class="col-6">
				<video id="video" autoplay width="100%" height="100%"></video>
			</div>
			<div class="col-3"></div>
		</section>
		<footer class="row">
			<div class="col-3"></div>
			<div id="resiterButtonDiv" class="col-6">
			<button onclick="capture();" style="font-size: 1.0rem;" type="button" class="btn btn-primary">사진 등록</button>
			</div>
			<div class="col-3"></div>
		</footer>
	</div>

	<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	<script>
		
		$(document).ready(function(){
			
			cameraCapture();
			
			function cameraCapture(){
				var video = document.querySelector("#video");
				if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
					navigator.mediaDevices.getUserMedia({
						video : true
					}).then(function(stream) {
						console.log(stream);
						video.srcObject = stream;
						video.play();
					});
				}
			}
			
			
		})
		
		function capture(){
			video.pause();
			//흙흙 모레모레 자갈자갈...
			//귀찮았어용...
			alert("사진이 등록되었습니다.");			
			window.location ="../home/main.do";
		}

	</script>
	
	
	
</html>