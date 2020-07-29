<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>self_driving</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mainPage.css">
		<!-- 부트스트랩 -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">		
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<!-- Popper JS -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
		<!-- 모바일 적절한 레더링 및 터치 확대 / 축소 보장 -->
		<!-- width = 장치 화면 너비에 따라 페이지 너비 설정, initial-scale = 페이지가 처음 브라우저에 의해로드 된 초기 줌 레벨 -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="${pageContext.request.contextPath}/resource/js/signup.js"></script>
	</head>
	<body>
		<!-- Sign in -->
	  	<!-- Modal -->
		<div style="margin-top: 5%; "class="modal fade" id="elegantModalForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		  aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <!--Content-->
		    <div class="modal-content form-elegant">
		      <!--Header-->
		      <div class="modal-header text-center">
		        <h3 class="modal-title w-100 dark-grey-text font-weight-bold my-3" id="myModalLabel"><strong>Sign in</strong></h3>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <!--Body-->
		      <div class="modal-body mx-4">
		        <!--Body-->
		        <div class="md-form mb-5">
		          <input type="email" id="Form-email1" class="form-control validate">
		          <label data-error="wrong" data-success="right" for="Form-email1">ID</label>
		        </div>
		
		        <div class="md-form pb-3">
		          <input type="password" id="Form-pass1" class="form-control validate">
		          <label data-error="wrong" data-success="right" for="Form-pass1">Password</label>
		          <p class="font-small blue-text d-flex justify-content-end">Forgot <a href="#" class="blue-text ml-1">
		              ID?</a></p>
	              <p class="font-small blue-text d-flex justify-content-end">Forgot <a href="#" class="blue-text ml-1">
		              Password?</a></p>
		        </div>
		
		        <div class="text-center mb-3">
		          <a href="control_center.do"><button style="background-color:#008CBA; ;"class="btn blue-gradient btn-block btn-rounded z-depth-1a">Sign in</button></a>
		        </div>

		      </div>
		      <!--Footer-->
		      <div class="modal-footer mx-5 pt-3 mb-1">
		        <p class="font-small grey-text d-flex justify-content-end">Not a member? <a href="#" class="blue-text ml-1">
		            Sign Up</a></p>
		      </div>
		    </div>
		    <!--/.Content-->
		  </div>
		</div>
		<!-- Modal -->
		<button style="float: right; margin: 1%; background-color: #008CBA; color: white;" href="" class="btn btn-default btn-rounded" data-toggle="modal" data-target="#elegantModalForm">Sign in</button>
		
		<!-- Sign up -->
		<div class="modal fade" id="modalRegisterForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		  aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header text-center">
		        <h4 class="modal-title w-100 font-weight-bold">Sign up</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body mx-3">
		        <div class="md-form mb-5">
		          <i class="fas fa-user prefix grey-text"></i>
		          <input type="text" id="orangeForm-name" class="form-control validate">
		          <label data-error="wrong" data-success="right" for="orangeForm-name">Your name</label>
		        </div>
		        <div class="md-form mb-5">
		          <i class="fas fa-envelope prefix grey-text"></i>
		          <input type="email" id="orangeForm-email" class="form-control validate">
		          <label data-error="wrong" data-success="right" for="orangeForm-email">Your email</label>
		        </div>
		
		        <div class="md-form mb-4">
		          <i class="fas fa-lock prefix grey-text"></i>
		          <input type="password" id="orangeForm-pass" class="form-control validate">
		          <label data-error="wrong" data-success="right" for="orangeForm-pass">Your password</label>
		        </div>
		
		      </div>
		      <div class="modal-footer d-flex justify-content-center">
		        <a href="signup.do"><button style="background-color: #008CBA; color: white"href="signup.do" class="btn btn-deep-orange">Sign up</button></a>
		      </div>
		    </div>
		  </div>
		</div>
		
		
	  <button style="float: right; margin: 1%; background-color: #008CBA; color: white; " href="" class="btn btn-default btn-rounded mb-4" data-toggle="modal" data-target="#modalRegisterForm">Sign up</button>
	</body>
</html>