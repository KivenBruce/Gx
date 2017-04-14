<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Cubic - One Page Responsive HTML 5 Website Template</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Responsive Minimal Bootstrap Theme">
<meta name="keywords"
	content="onepage,responsive,minimal,bootstrap,theme">
<meta name="author" content="">
<meta http-equiv="Expires" CONTENT="0">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<script src="http://localhost:8080/Gx/js/jquery.min.js"></script>


<!-- CSS Files
    ================================================== -->
<link rel="stylesheet" href="http://localhost:8080/Gx/css/bootstrap.css"
	type="text/css">
<link rel="stylesheet"
	href="http://localhost:8080/Gx/css/jpreloader.css" type="text/css">
<link rel="stylesheet" href="http://localhost:8080/Gx/css/animate.css"
	type="text/css">



<link rel="stylesheet" href="http://localhost:8080/Gx/css/style.css"
	type="text/css">

<!-- custom style css -->
<link rel="stylesheet"
	href="http://localhost:8080/Gx/css/custom-style.css" type="text/css">

<!-- color scheme -->
<link rel="stylesheet" href="http://localhost:8080/Gx/css/color.css"
	type="text/css">


<!-- load fonts -->
<link rel="stylesheet"
	href="http://localhost:8080/Gx/fonts/font-awesome/css/font-awesome.css"
	type="text/css">
<script type="text/javascript">
	function reImg() {
		var img = document.getElementById("img1");
		img.src = "http://localhost:8080/Gx/image.jsp" + '?abc='
				+ Math.random();
	}
</script>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "No-cache");
	response.setDateHeader("Expires", -1);
	response.setHeader("Cache-Control", "No-store");
%>
<script type="text/javascript">
$(function(){
    if (window.history && window.history.pushState) {
        $(window).on('popstate', function () {
              window.history.forward(1);
        });
      }
})
</script>
</head>

<body id="homepage">



	<div id="wrapper">
		<div class="page-overlay"></div>


		<!-- header begin -->
		<header>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<!-- logo begin -->
						<h1 id="logo">
							<a href="index.jsp"> <img class="logo-1"
								src="http://localhost:8080/Gx/images/school.png" alt=""> <img
								class="logo-2" src="http://localhost:8080/Gx/images/logo-2.png"
								alt="">
							</a>
						</h1>
						<!-- logo close -->

						<!-- small button begin -->
						<span id="menu-btn"></span>
						<!-- small button close -->

						<!-- mainmenu begin -->
						<nav>
							<ul id="mainmenu">
								<li><a href="Index">首页</a></li>
								<li><a href="Register">注册</a></li>
							</ul>
						</nav>

					</div>
					<!-- mainmenu close -->

				</div>
			</div>
		</header>
		<!-- header close -->


		<!-- content begin -->
		<div id="content" class="no-bottom no-top">
			<!-- section begin -->
			<section id="section-contact" class="dark" data-speed="5"
				data-type="background">
				<div class="container">
					<div class="row">
						<div class="col-md-12 text-center">
							<h1 class="animated" data-animation="fadeInUp">
								登<span class="id-color">陆</span>

							</h1>

							<div class="spacer-single"></div>
						</div>

						<div class="col-md-8 animated" data-animation="fadeInUp"
							data-delay="200" data-speed="5">

							<form name="contactForm" id='contact_form' method="post"
								action='LoginS.do'>
								<div class="row">
									<div class="col-md-6">
										<div id='name_error' class='error'>用户名不能为空！</div>
										<div id='user_error' class='error' style="display: none">你输入的密码和账户名不匹配！</div>
										<div>
											<input type='text' name='name' id='name' class="form-control" autocomplete="off"
												placeholder="用户名">
										</div>
									</div>
									<div class="col-md-8"></div>
									<div class="col-md-6">
										<div id='pwd_error' class='error'>密码不能为空！</div>
										<div>

											<input type='password' name='pwd' id='pwd'
												class="form-control" placeholder="密码">
										</div>
									</div>
									<div class="col-md-8"></div>
									<div class="col-md-6">
										<div id='lab1_error' class='error'>验证码不正确！</div>
										<div>
											<input type='text' name='lab1' id='lab1' placeholder="验证码"autocomplete="off">
											<label for="male"><img id="img1"
												src="http://localhost:8080/Gx/image.jsp" alt="验证码" /></label> <a
												href="#" onclick="reImg();">看不清，换一张</a>
										</div>
									</div>


									<div id='mail_success' class='success'>Your message has
										been sent successfully.</div>
									<div id='mail_fail' class='error'>Sorry, error occured
										this time sending your message.</div>
									<div class="col-md-12">
										<p id='submit'>
											<input type='submit' id='send_message' value='登 陆'
												class="btn btn-border">
										</p>
									</div>
								</div>
							</form>

						</div>

						<div class="col-md-4">
							<address>
								<span><i class="fa fa-map-marker fa-lg"></i>北京-信息-科技-大学</span> <span><i
									class="fa fa-phone fa-lg"></i>13269393859</span> <span><i
									class="fa fa-envelope-o fa-lg"></i><a
									href="mailto:contact@example.com">1369250896@qq.com</a></span> <span><i
									class="fa fa-globe fa-lg"></i><a href="Index">主页</a></span>
							</address>
						</div>
					</div>
				</div>
			</section>
			<!-- section close -->

			<!-- footer begin -->
			<footer>
				<div class="container">
					<div class="row">
						<div class="col-md-12 text-center">
							<div class="social-icons">
								<a href="#"><i class="fa fa-facebook fa-lg"></i></a> <a href="#"><i
									class="fa fa-twitter fa-lg"></i></a> <a href="#"><i
									class="fa fa-envelope-o fa-lg"></i></a> <a href="#"><i
									class="fa fa-google-plus fa-lg"></i></a> <a href="#"><i
									class="fa fa-skype fa-lg"></i></a>
							</div>
							<div class="spacer-single"></div>
							© Copyright 2014 - Cubic by Designesia
						</div>
					</div>
				</div>
			</footer>
			<!-- footer close -->
		</div>
	</div>


	<!-- Javascript Files
    ================================================== -->
	<script src="http://localhost:8080/Gx/js/jquery.min.js"></script>
	<script src="http://localhost:8080/Gx/js/jpreLoader.js"></script>


	<script src="http://localhost:8080/Gx/js/jquery.prettyPhoto.js"></script>

	<script src="http://localhost:8080/Gx/js/jquery.ui.totop.js"></script>


	<script src="http://localhost:8080/Gx/js/owl.carousel.js"></script>

	<script src="http://localhost:8080/Gx/js/classie.js"></script>
	<script src="http://localhost:8080/Gx/js/designesia.js"></script>
	<script src="http://localhost:8080/Gx/js/validation-login.js"></script>
</body>
<script type="text/javascript">
<%String mark = (String) request.getAttribute("mark");
			if (mark == "failure") {%>
			$("#lab1_error").show().delay(3000).hide(0);
	/* document.getElementById("lab1_error").style = "display:block"; */
	document.getElementById("name").value="<%=request.getAttribute("username")%>";
	document.getElementById("pwd").value="<%=request.getAttribute("password")%>";
<%}
			if (mark == "none") {%>
			$("#user_error").show().delay(5000).hide(0);
			/* document.getElementById("user_error").style = "display:block"; */
			document.getElementById("name").value="<%=request.getAttribute("username")%>";
<%}%>
	
</script>
</html>
