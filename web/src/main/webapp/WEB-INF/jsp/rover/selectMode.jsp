<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>No. 15</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<!-- bootswatch slate theme -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/selectMode.css">

</head>
<body>
	<div class="container-fluid vh-100">
		<header class="row">
			<div class="col-3"></div>
			<div id="roverNameDiv" class="col-6">${rover.rname}</div>
			<div id="userIdDiv" class="col-3">${rover.ruser}</div>
		</header>
		<section class="row">
			<div class="col-4 d-flex align-items-center justify-content-center">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">AI Mode</h5>
						<p class="card-text">Car drives automatically without
							manipulation.</p>
						<form name="aiMode" method="post" action="aiMode.do">
						<input type="hidden" name="rname" value="${rover.rname}"/>
						<input type="hidden" name="ruser" value="${rover.ruser}"/>
						<input type="hidden" name="rip" value="${rover.rip}"/>
						<input type="hidden" name="rtype" value="${rover.rtype}"/>
						<button type="submit" class="btn btn-primary">Activate</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-4 d-flex align-items-center justify-content-center">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Manual Mode</h5>
						<p class="card-text">Full control of car by manipulation.</p>
						<form name="manualMode" method="post" action="manualMode.do">
						<input type="hidden" name="rname" value="${rover.rname}"/>
						<input type="hidden" name="ruser" value="${rover.ruser}"/>
						<input type="hidden" name="rip" value="${rover.rip}"/>
						<input type="hidden" name="rtype" value="${rover.rtype}"/>
						<button type="submit" class="btn btn-primary">Activate</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-4 d-flex align-items-center justify-content-center">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Navigation Mode</h5>
						<p class="card-text">Car drives automatically from and to
							destination set.</p>
						<form name="navigationMode" method="post" action="navigationMode.do">
						<input type="hidden" name="rname" value="${rover.rname}"/>
						<input type="hidden" name="ruser" value="${rover.ruser}"/>
						<input type="hidden" name="rip" value="${rover.rip}"/>
						<input type="hidden" name="rtype" value="${rover.rtype}"/>
						<button type="submit" class="btn btn-primary">Activate</button>
						</form>
					</div>
				</div>
			</div>
		</section>
		<footer id="infoButtonDiv" class="row">
	
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary btn-lg"
				data-toggle="modal" data-target="#carInfo">Info</button>

			<!-- Modal -->
			<div class="modal fade" id="carInfo" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="myModalLabel">Car Information</h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<ul>
								<li>Name: ${rover.rname}</li>
								<li>Type: ${rover.rtype}</li>
								<li>IP : ${rover.rip}</li>
								<li>Distance: ${rover.rdistance}</li>
							</ul>
						</div>
						<div class="modal-footer">
							<form id="delete" method="post" action="deleteRover.do">
								<input type="hidden" name="rname" value="${rover.rname}">
							</form>
							<button type="submit" class="btn btn-danger" form="delete">Delete</button>
							<button type="button" class="btn btn-primary" data-toggle="modal"
								data-target="#blackBox" data-dismiss="modal" onclick="playBlackBox(0)">Black Box</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="blackBox" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="myModalLabel">BlackBox</h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div id="blackBoxImageDiv" class="modal-body">
							<img id="blackBoxImage" alt="기록 없음" src=""/>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>

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
	<script
		src="${pageContext.request.contextPath}/resource/js/selectMode.js"></script>
</body>
</html>