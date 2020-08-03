<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mainPage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/birthday.css">

<!-- Sign in -->
	  	<!-- Modal -->
		<div style="margin-top: 5%; "class="modal fade" id="elegantModalForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		  aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <!--Content-->
		    <div class="modal-content form-elegant">
		      <!--Header-->
		      <div class="modal-header text-center">
		        <h3 style="font-size: 30px;" class="modal-title w-100 dark-grey-text font-weight-bold my-3" id="myModalLabel"><strong>로그인</strong></h3>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <!--Body-->
		      <div class="modal-body mx-4">
		        <!--Body-->
		        <div class="md-form mb-3">
		          <label style="font-size: 1.2rem;" data-error="wrong" data-success="right" for="Form-email1">아이디</label>
		          <input type="email" id="Form-email1" class="form-control validate">
		        </div>
		
		        <div class="md-form pb-3">
		          <label style="font-size: 1.2rem;" data-error="wrong" data-success="right" for="Form-pass1">비밀번호</label>
		          <input type="password" id="Form-pass1" class="form-control validate">
		          <p style="font-size: 0.9rem;" class="font-small blue-text d-flex justify-content-end"><a href="#" class="blue-text ml-1">아이디 찾기</a></p>
	              <p style="font-size: 0.9rem;" class="font-small blue-text d-flex justify-content-end"><a href="#" class="blue-text ml-1">비밀번호 찾기</a></p>
		        </div>
		        <div class="text-center mb-3">
		          <a href="main.do"><button style="color: white;background-color:#008CBA; ;"class="btn blue-gradient btn-block btn-rounded z-depth-1a">로그인</button></a>
		        </div>
		      </div>
		    </div>
		    <!--/.Content-->
		  </div>
		</div>