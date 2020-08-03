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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap">
</head>
<body>
	
	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#carInfo">
  Info
</button>

<!-- Modal -->
<div class="modal fade" id="carInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Car Information</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <ul>
        	<li>Name: car1</li>
        	<li>Type: jetRacer</li>
        	<li>IP/port: 192.168.3.242/8080</li>
        	<li>Distance: 10000km</li>
        	
        </ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#blackBox">Black Box</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="blackBox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">주행 경로</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
		<div style="border: solid 1px; height: 300px; width: 300px;">
		
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
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