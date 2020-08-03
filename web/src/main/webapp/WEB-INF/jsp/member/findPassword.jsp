<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/mainPage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/birthday.css">

<!-- Find Password -->
<!-- Modal -->
<div style="margin-top: 5%;" class="modal fade"
	id="findPasswordModalForm" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<!--Content-->
		<div class="modal-content form-elegant">
			<!--Header-->
			<div class="modal-header text-center">
				<h3 style="font-size: 30px;"
					class="modal-title w-100 dark-grey-text font-weight-bold my-3"
					id="myModalLabel">
					<strong>비밀번호 찾기</strong>
				</h3>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body mx-4">
				<!--Body-->

				<div class="md-form mb-3">
					<i class="fas fa-user prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-name">아이디</label> <input
						type="text" id="orangeForm-id" class="form-control validate">
				</div>

				<div class="md-form mb-3">
					<i class="fas fa-user prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-name">이름</label> <input
						type="text" id="orangeForm-name" class="form-control validate">
				</div>

				<div class="md-form mb-3">
					<i class="fas fa-envelope prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-email">이메일</label> <input
						type="email" id="orangeForm-email" class="form-control validate">
					<button style="float: right; margin-top: 1px; border: none;">인증하기</button>
				</div>

				<div class="md-form pb-3">
					<i class="fas fa-envelope prefix grey-text"></i> <label
						style="margin-bottom: 0px; font-size: 20px;" data-error="wrong"
						data-success="right" for="orangeForm-conf">인증번호</label> <input
						type="text" id="orangeForm-email" class="form-control validate">
					<button style="float: right; margin-top: 1px; border: none;">인증</button>
				</div>

				<div class="modal-footer d-flex justify-content-center">
					<a href="main.do"><button
							style="background-color: #008CBA; color: white"
							class="btn btn-deep-orange">확인</button></a>
				</div>

			</div>
		</div>
		<!--/.Content-->
	</div>
</div>