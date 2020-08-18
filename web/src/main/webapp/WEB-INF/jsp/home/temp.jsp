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
<script
	src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<script
	src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"
	type="text/javascript"></script>
<head>
<meta charset="utf-8">
<style>
#container {
	margin: 0px auto;
	width: 500px;
	height: 375px;
	border: 10px #333 solid;
}

#videoElement {
	width: 500px;
	height: 375px;
	background-color: #666;
}
</style>
</head>

<body>
	<video id="video" width="640" height="480" autoplay></video>
	<button id="snap">Snap Photo</button>
	<canvas id="canvas" width="640" height="480"></canvas>
	<script>
	var video = $('#video');
	// Get access to the camera!
	if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
	    navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
	        //video.src = window.URL.createObjectURL(stream);
	        video.srcObject = stream;
	        video.play();
	    });
	}
	

	
	// Elements for taking the snapshot
	var canvas = document.getElementById('canvas');
	var context = canvas.getContext('2d');
	var video = document.getElementById('video');

	// Trigger photo take
	document.getElementById("snap").addEventListener("click", function() {
		context.drawImage(video, 0, 0, 640, 480);
	});
</script>

</body>
</html>