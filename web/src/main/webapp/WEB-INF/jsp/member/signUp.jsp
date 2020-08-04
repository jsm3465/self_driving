<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/mainPage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/birthday.css">
<!-- Sign up -->
<div class="modal fade" id="modalRegisterForm" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header text-center">
				<h4 style="font-size: 30px;"
					class="modal-title w-100 font-weight-bold">회원 가입</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body mx-3">
				<div class="md-form mb-1">
					<i class="fas fa-user prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-name">아이디</label> <input
						type="text" id="orangeForm-id" class="form-control validate">
				</div>

				<div class="md-form mb-1">
					<i class="fas fa-lock prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-pass">비밀번호</label> <input
						type="password" id="orangeForm-pass" class="form-control validate">
				</div>

				<div class="md-form mb-1">
					<i class="fas fa-user prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-pass">비밀번호 재확인</label> <input
						type="password" id="orangeForm-pass" class="form-control validate">
				</div>

				<div class="md-form mb-1">
					<i class="fas fa-user prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-name">이름</label> <input
						type="text" id="orangeForm-name" class="form-control validate">

				</div>

				<div class="md-form mb-1">
					<i class="fas fa-user prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-sex">성별</label> <select
						id="orangeForm-sex">
						<option value="남">남</option>
						<option value="여">여</option>
					</select>
				</div>
				<div class="md-form mb-1">
					<i class="fas fa-user prefix grey-text"></i>
					<div class="bir_wrap">
						<label style="margin-bottom: 0px; font-size: 20px;"
							data-error="wrong" data-success="right" for="orangeForm-bir">생년월일</label></br>
						<input type="text" id="orangeForm-yy" class="bir_yy"
							placeholder="년(4자)" aria-label="(년4자)" maxlength="4"> <select
							id="orangeForm-mm" class="bir_mm" aria-label="월">
							<option>월</option>
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
						</select> <select id="orangeForm-dd" class="bir_dd" aria-label="일">
							<option>일</option>
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
				</div>

				<div class="md-form mb-1">
					<i class="fas fa-envelope prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-email">이메일</label> <input
						type="email" id="orangeForm-email" class="form-control validate">
					<button style="float: right; margin-top: 1px; border: none;">인증하기</button>
				</div>

				<div class="md-form mb-1">
					<i class="fas fa-envelope prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-conf">인증번호</label> <input
						type="text" id="orangeForm-email" class="form-control validate">
					<button style="float: right; margin-top: 1px; border: none;">인증</button>
				</div>
			</div>
			<div class="modal-footer d-flex justify-content-center">
				<a href="faceResist.do"><button
						style="background-color: #008CBA; color: white"
						class="btn btn-deep-orange">다음</button></a>
			</div>
		</div>
	</div>
</div>