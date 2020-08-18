<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="deleteMember.jsp" />
<jsp:include page="changePassword.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Information</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/signUp.css">
</head>
<body>
	<div class="container-fluid vh-100 vw-100">
		<div style="height: 10%" class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4" id="logobox">
				<a href="main.do" id="logo">Autonomous Driving</a>
			</div>
			<div class="col-md-4"></div>
		</div>
		<div style="height: 60%" class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<form:form method="post" action="memberUpdate.do" modelAttribute="member" >
					<div class="md-form mb-1">
						<i class="fas fa-user prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-name">아이디</label> <form:input path="mid"
							style="margin-bottom: 20px;" name="mid" readonly="true"
							type="text" value="${member.mid}" id="orangeForm-id"
							class="form-control validate"/>
					</div>

					<div class="md-form mb-1">
						<div class="row">
							<div class="col-md-10">
								<i class="fas fa-lock prefix grey-text"></i> <label
									style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
									data-success="right" for="orangeForm-pass">비밀번호</label> <input
									style="margin-bottom: 20px;" type="password"
									readonly="true" value="${member.mpassword}"
									id="orangeForm-pass" class="form-control validate"/></br>
							</div>
							<div class="col-md-2">
								<button
									style="margin-top: 30px; background-color: #AAAAAA; color: white; width: 100%; font-size: large;"
									type="button" class="btn btn-primary" data-toggle="modal"
									data-target="#changePassword">변경</button>
							</div>
						</div>
					</div>

					<div class="md-form mb-1">
						<i class="fas fa-user prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-name">이름</label> <form:input path="mname"
							style="margin-bottom: 20px;" name="mname" type="text"
							value="${member.mname}"
							id="orangeForm-name" class="form-control validate"/>
							<form:errors path="mname" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form mb-1">
						<i class="fas fa-user prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
							data-success="right" for="orangeForm-sex">성별</label> </br> <select
							style="margin-bottom: 20px; width: 100%; height: 38px; font-size: 20px;"
							id="orangeForm-sex" name="msex">
							<option value="남">남</option>
							<option value="여">여</option>
						</select>
					</div>
					<div class="md-form mb-1">
						<i class="fas fa-user prefix grey-text"></i>
						<div class="bir_wrap">
							<label style="margin-bottom: 0px; font-size: 20px;"
								data-error="wrong" data-success="right" for="orangeForm-bir">생년월일</label></br>
							<input type="text" id="orangeForm-yy" class="bir_yy" value="${birth_y}"
								name="mbirth" placeholder="${birth_y}" aria-label="(년4자)"
								maxlength="4"/> <select id="orangeForm-mm" class="bir_mm"
								aria-label="월" name="mbirthM">
								<option>${birth_m}</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select> <select id="orangeForm-dd" class="bir_dd" aria-label="일"
								name="mbirthD">
								<option>${birth_d}</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">20</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
							</select>
							<form:errors path="mbirth" style="color:red; font-size:1.0rem" />
						</div>
					</div>

					<div class="md-form mb-1">
						<i class="fas fa-envelope prefix grey-text"></i> <label
							style="margin-bottom: 0px; font-size: 20px; margin-top: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-email">이메일</label>
						<form:input path="memail" style="margin-bottom: 20px;" name="memail" readonly="true" 
							value="${member.memail}"
							type="email" id="orangeForm-email" class="form-control validate"/>
					</div>

					<div class="md-form mb-1" style="height: 50px;">
						<div class=row>
							<div class="col-md-6">
								<button
									style="background-color: #AAAAAA; color: white; width: 100%; font-size: large;"
									class="btn btn-deep-orange">수정</button>
							</div>
							<div class="col-md-6">
								<a
									style="background-color: #AAAAAA; color: white; width: 100%; font-size: large;"
									type="button" class="btn btn-primary" data-toggle="modal"
									data-target="#deleteMember">회원 탈퇴</a>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>


	<script
		src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/email.js"></script>
</body>
</html>