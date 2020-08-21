<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE HTML>
<html>
	<head>
		<title>Autonomous Driving</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css" />
		<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/noscript.css"/></noscript>
	</head>
	<body class="landing is-preload">
<body>
		<!-- Page Wrapper -->
			<div id="page-wrapper">

				<!-- Header -->
					<header id="header" class="alt">
						<nav id="nav">
							<ul>
								<li class="special">
									<a href="#menu" class="menuToggle"><span>Menu</span></a>
									<div id="menu">
										<ul>
											<li><a href="main.do">Home</a></li>
											<c:if test="${sessionMid != null}">
												<li><a href="../rover/roverList.do">Rover List</a></li>
												<li><a href="controlView.do">Control View</a></li>
												<li><a href="../member/memberInformationForm.do">User Info</a></li>
												<li><a href="../member/signout.do">Logout</a></li>
											</c:if>
										</ul>
									</div>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Banner -->
					<section id="banner">
						<div class="inner">
							<h2>Autonomous Driving</h2>
							<p>Welcome to<br />
							the control center of<br />
							the autonomous driving system</p>
							<ul class="actions special">
								<c:if test="${sessionMid == null}">
									<li><a href="../member/signinForm.do" class="button primary">Sign In</a></li>
									<li><a href="../member/signupForm.do" class="button primary">Sign Up</a></li>
								</c:if>
							</ul>
						</div>
					</section>

				<!-- Footer -->
					<footer id="footer">
						<ul class="icons">
							<li><span class="label">@SANGMIN</span></li>
							<li><span class="label">@SUNGJIN</span></li>
							<li><span class="label">@CHANYHEOK</span></li>
							<li><span class="label">@WHIRAE</span></li>
							<li><span class="label">@YEHNA</span></li>
							<li><span class="label">@HYEONGWOOK</span></li>
						</ul>
						<ul class="copyright">
							<li>&copy;IOT CLASS</li><li>Design: ANYWHERE</li>
						</ul>
					</footer>
			</div>

		<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/jquery.scrollex.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/resource/js/main.js"></script>

	</body>
</html>
