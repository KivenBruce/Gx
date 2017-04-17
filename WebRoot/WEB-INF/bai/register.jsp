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
<title>Cubic - 注册</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
#reset_message {
	background-color: black;
}

#style1 {
	background-color: #428bca;
}
.wells {
	background-color: #2e1e1e;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
	margin-bottom: -60px;
	min-height: 20px;
	padding: 19px;
	text-align: center;
}
</style>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">
<link rel="stylesheet" href="css/jpreloader.css" type="text/css">
<link rel="stylesheet" href="css/animate.css" type="text/css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<!-- custom style css -->
<link rel="stylesheet" href="css/custom-style.css" type="text/css">
<!-- color scheme -->
<link rel="stylesheet" href="css/color.css" type="text/css">
<!-- load fonts -->
<link rel="stylesheet" href="fonts/font-awesome/css/font-awesome.css"
	type="text/css">
</head>
<body id="homepage">
	<div id="wrapper">
		<div class="page-overlay"></div>
		<header>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<!-- logo begin -->
						<h1 id="logo">
							<a href="index.html"> <img class="logo-1"
								src="images/logo.png" alt=""> <img class="logo-2"
								src="images/logo-2.png" alt="">
							</a>
						</h1>
						<span id="menu-btn"></span>

						<nav>
							<ul id="mainmenu">
								<li><a href="Index">首页</a></li>
								<li><a href="Login">登陆</a></li>
							</ul>
						</nav>

					</div>
				</div>
			</div>
		</header>
		<div id="content" class="no-bottom no-top">

			<section id="section-contact" class="dark" data-speed="5"
				style="height: 570px" data-type="background">
				<div class="container">
					<div class="row">
						<div class="col-md-12 text-center">
							<h1 class="animated" data-animation="fadeInUp">
								注<span class="id-color">册</span>

							</h1>

							<div class="spacer-single"></div>
						</div>
						</br> </br>
						<div class="col-md-8 animated" data-animation="fadeInUp"
							data-delay="200" data-speed="5">

							<form name="contactForm" id='contact_form' method="post"
								action='RegisterS'>
								<div class="row">
									<div class="col-md-6">
										<div id='name_error' class='error'>用户名不能为空！</div>
										<div id='regist_error' class='error' style="display: none">该用户已经被注册！</div>
										<div>
											<input type='text' name='name' id='name' class="form-control"
												maxlength="10" placeholder="用户名">
										</div>
									</div>
									<div class="col-md-8"></div>
									<div class="col-md-6">
										<div id='pwd_error' class='error'>密码不能为空！</div>
										<div id='longpwd_error' class='error'>密码长度错误！</div>
										<div>
											<input type='password' name='pwd' id='pwd' maxlength="10"
												class="form-control" placeholder="密码">
										</div>
									</div>
									<div class="col-md-6">
										<div id='pwd2_error' class='error'>密码不一致！</div>
										<div>
											<input type='password' name='pwd2' id='pwd2' maxlength="10"
												class="form-control" placeholder="重复密码">
										</div>
									</div>
									<div class="col-md-8"></div>
									<div class="col-md-6">
										<div id='email_error' class='error'>邮箱格式不正确!</div>
										<div>
											<input type='text' name='email' id='email'
												class="form-control" placeholder="邮箱">
										</div>
									</div>
									<div class="col-md-8"></div>
									<div class="col-md-6">
										<div id='tel_error' class='error'>电话号码格式不正确!</div>
										<div>
											<input type='text' name='tel' id='tel' class="form-control"
												placeholder="电话号码">
										</div>
									</div>
									<div class="col-md-8"></div>

									<div id='mail_success' class='success'>Your message has
										been sent successfully.</div>
									<div id='mail_fail' class='error'>Sorry, error occured
										this time sending your message.</div>
									<table class="col-md-12">
										<tr>
											<td>
												<p id='submit'>
													<input type='submit' id='send_message' value='提 交'
														class="btn btn-border" style="margin-left: 100px">
													<input type='reset' value='重置' id='reset_message'
														class="btn btn-border" style="margin-left: 10px"
														onmouseover="this.id='style1'"
														onmouseout="this.id='reset_message'">
												</p>
											</td>
										</tr>
									</table>


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

			<footer class="wells">
				Copyright © 1999-2016,<a href="http://www.bistu.edu.cn/"
					target="_blank" title="Bistu">MyBistu </a>All Rights Reserved
			</footer>
		</div>
	</div>


	<!-- Javascript Files
    ================================================== -->
	<script src="js/jquery.min.js"></script>
	<script src="js/jpreLoader.js"></script>
	<script src="js/jquery.prettyPhoto.js"></script>
	<script src="js/jquery.ui.totop.js"></script>
	<script src="js/owl.carousel.js"></script>
	<script src="js/classie.js"></script>
	<script src="js/designesia.js"></script>
	<script type="text/javascript" src="js/validation-regist.js"
		charset="UTF-8"></script>
</body>
<script type="text/javascript">
<%String mark = (String) request.getAttribute("mark");
			if (mark == "have") {%>		
	document.getElementById("regist_error").style = "display:block";
	
	document.getElementById("name").value="<%=request.getAttribute("username")%>";
	document.getElementById("pwd").value="<%=request.getAttribute("pwd")%>";
	document.getElementById("pwd2").value="<%=request.getAttribute("pwd2")%>";
	document.getElementById("email").value="<%=request.getAttribute("email")%>";
	document.getElementById("tel").value="<%=request.getAttribute("tel")%>";
<%}%>
	
</script>
</html>
