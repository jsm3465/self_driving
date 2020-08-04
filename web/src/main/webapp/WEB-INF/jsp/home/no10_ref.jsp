<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>No. 10</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script> // canvas 크기를 조정
            var _canvas;
            
            window.onload = function(e) {
                _canvas = document.querySelector("#mapCanvas");        
                setCanvasSize();
                console.log("load")
            }
            
            window.onresize = function(e) {
                setCanvasSize();
                console.log("resize")
            }
            
            function setCanvasSize() {
                _canvas.width = _canvas.parentNode.clientWidth;
                console.log(_canvas.parentElement)
                console.log(_canvas.width)
                _canvas.height = _canvas.parentNode.clientHeight;
                console.log(_canvas.height)
            }
       </script>
	</head>
	<body>
	
	<div class="container-fluid">
		<div class="row vh-100">
			<div class="col-4">
				<h1>Control Center</h1>
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
					<canvas id="mapCanvas" style="border:1px solid #000000;"></canvas>				
				</div>
				
			</div>
		</div>
	</div>
	
	</body>
</html>