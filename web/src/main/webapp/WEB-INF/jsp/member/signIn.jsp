<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Autonomous Driving</title>
<meta charset="utf-8" />
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
      <div style="height: 20%;" class=row>
         <div class="col-45"></div>
         <div class="col-3"></div>
         <div class="col-45"></div>
      </div>
      <div style="height: 80%;" class=row>
         <div class="col-45"></div>
         <div id="logoDiv" class="col-3">
            <center>
               <h2 style="margin-top: 23.4px;">
                  <a id="logo" href="main.do">Autonomous Driving</a>
               </h2>
            </center>
            <form:form method="post" action="signin.do" modelAttribute="member">
               <div style="margin-top: 3%;">
                  <i class="fas fa-user prefix grey-text"></i> <a>아이디</a>
                  <form:input path="mid" name="mid" type="text" id="mid"
                     class="form-control validate" />
                  <form:errors path="mid" style="color:red; font-size:1.0rem" />
               </div>

               <div style="margin-top: 3%;">
                  <i class="fas fa-lock prefix grey-text"></i> <a>비밀번호</a>
                  <form:input path="mpassword" type="password" id="mpassword"
                     class="form-control validate" name="mpassword" />
                  <form:errors path="mpassword" style="color:red; font-size:1.0rem" />
               </div>
               <div style="margin-top: 3%; text-align: right; font-size: 15px;">
                  <a href="${pageContext.request.contextPath}/member/findIdForm.do">아이디
                     찾기</a>
               </div>
               <div style="margin-top: 3%; text-align: right; font-size: 15px;">
                  <a id="findPassword"
                     href="${pageContext.request.contextPath}/member/findPasswordForm.do">비밀번호
                     찾기</a>
               </div>
               <div style="margin-top: 3%; font-size: 20px;">
                  <button style="width: 100%;" class="button primary fit">Login</button>
               </div>
            </form:form>
         </div>
      </div>
   </div>
   <script
      src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
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
</body>
</html>
