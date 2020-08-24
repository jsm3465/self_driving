<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="deleteMember.jsp" />
<jsp:include page="changePassword.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Information</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/main.css" />
<noscript>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resource/css/noscript.css" />
</noscript>
</head>
<body>
	<div class="container-fluid vh-100 vw-100">
		<div style="height: 15%" class="row">
			<div class="col-45"></div>
			<div id="logoDiv" class="col-3" style="margin-top: 50px">
				<center>
					<h2>
						<a href="main.do" id="logo">Autonomous Driving</a>
					</h2>
				</center>
			</div>
			<div class="col-45"></div>
		</div>
		<div style="height: 85%" class="row">
			<div class="col-45"></div>
			<div class="col-3">
				<form:form method="post" action="memberUpdate.do"
					modelAttribute="member">
					<div class="md-form mb-1">
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-name">
							<i class="fas fa-user prefix grey-text"></i>아이디
						</label>
						<form:input path="mid" style="margin-bottom: 20px;" name="mid"
							readonly="true" type="text" value="${member.mid}"
							id="orangeForm-id" class="form-control validate" />
					</div>

					<div class="md-form mb-1">
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-pass">
							<i class="fas fa-lock prefix grey-text"></i>비밀번호
						</label>
						<div>
							<input style="width: 100%;" type="password"
								readonly="true" value="${member.mpassword}" id="orangeForm-pass"
								class="form-control validate" /> <a type="button"
								style="float: right; margin-bottom: 20px; border: none; font-size: 15px;"
								data-toggle="modal" data-target="#changePassword">변경</a>
						</div>

					</div>

					<div class="md-form mb-1">
						<label style="margin-top: 20px; margin-bottom: 0px;font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-name">
							이름</label>
						<form:input path="mname" style="margin-bottom: 20px;" name="mname"
							type="text" value="${member.mname}" id="orangeForm-name"
							class="form-control validate" />
						<form:errors path="mname" style="color:red; font-size:1.0rem" />
					</div>

					<div class="md-form mb-1">
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-sex">
							성별</label><select
							style="margin-bottom: 20px; width: 100%; height: 38px; font-size: 20px; color: #000000;"
							id="orangeForm-sex" name="msex">
							<option value="남">남</option>
							<option value="여">여</option>
						</select>
					</div>
					<div class="md-form mb-1">
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-bir">생년월일</label>
						<div class="row">
							<div class="col-4">
								<input type="text" id="year" class="bir_yy" value="${birth_y}"
									name="mbirth" placeholder="${birth_y}" aria-label="(년4자)"
									maxlength="4" />
							</div>
							<div class="col-4">
								<select id="orangeForm-mm" class="bir_mm" aria-label="월"
									name="mbirthM">
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
								</select>
							</div>
							<div class="col-4">
								<select id="orangeForm-dd" class="bir_dd" aria-label="일"
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
							</div>
							<form:errors path="mbirth" style="color:red; font-size:1.0rem" />
						</div>
					</div>

					<div class="md-form mb-1">
						<label
							style="margin-bottom: 0px; font-size: 20px; margin-top: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-email">
							<i class="fas fa-envelope prefix grey-text"></i>이메일
						</label>
						<form:input path="memail" style="margin-bottom: 20px;"
							name="memail" readonly="true" value="${member.memail}"
							type="email" id="orangeForm-email" class="form-control validate" />
					</div>

					<div class="md-form mb-1" style="height: 50px;">
						<div class=row>
							<div class="col-md-6">
								<button style="margin-left: 3px; width: 90%; font-size: large;"
									class="button primary fit">수정</button>
							</div>
							<div class="col-md-6">
								<a style="margin-left: 3px; width: 90%; font-size: large;"
									type="button" class="button primary fit" data-toggle="modal"
									data-target="#deleteMember">회원 탈퇴</a>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<div class="col-45"></div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/jquery.scrollex.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/jquery.scrolly.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/browser.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/breakpoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/util.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/main.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/email.js"></script>
</body>
</html>