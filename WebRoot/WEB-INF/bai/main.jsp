<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />

<link rel="stylesheet" href="css/bootstrap.css" type="text/css">
<link rel="stylesheet" href="css/jpreloader.css" type="text/css">
<link rel="stylesheet" href="css/animate.css" type="text/css">
<link rel="stylesheet" href="css/owl.carousel.css" type="text/css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<!-- color scheme -->
<link rel="stylesheet" href="css/color.css" type="text/css">
<!-- custom style css -->
<link rel="stylesheet" href="css/custom-style.css" type="text/css">
<link rel="stylesheet" href="fonts/font-awesome/css/font-awesome.css"
	type="text/css">
<link rel="stylesheet" href="css/count.css" type="text/css">
<!-- 自定义css,count样式 -->
<!-- Javascript Files
    ================================================== -->
<script src="js/jquery.min.js"></script>
<script src="js/jpreLoader.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<script src="js/jquery.ui.totop.js"></script>
<script src="js/owl.carousel.js"></script>
<script src="js/classie.js"></script>
<script src="js/designesia.js"></script>
<script src="js/search.js"></script>
<!-- 自定义js -->
</head>
<body id="homepage">

	<!-- This section is for Splash Screen -->
	<div class="user-info" style="float: right; font-size: 120px">hello</div>

	<div id="wrapper">
		<div class="page-overlay"></div>
		<!-- header begin -->
		<header>
			<div class="container">
				<div class="row">

					<div class="col-md-12">
						<h1 id="logo">
							<a href="index.jsp"> <img class="logo-1"
								src="images/logo.png" alt=""> <img class="logo-2"
								src="images/logo-2.png" alt="">
							</a>
						</h1>
						<span id="menu-btn"></span> <span id="newinput"><input
							id="q" name="q" autocomplete="off"							
							value="" maxlength="280px" placeholder="搜索你感兴趣的内容..." type="text" /></span>
						<span><input id="searchimg" type="image"
							src="/Gx/adminjsps/img/search1.png"
							style="width: 40px; vertical-align: middle; margin-left: -4px; border-radius: 4px"
							onclick="search()" /></span>


						<ul id="mainmenu">
							<li><a href="Main.do" class="active">首页</a></li>
							<li><a
								href="<c:url value='/FrontServlet?method=findAll&type=in'/>">校内活动</a></li>
							<li><a
								href="<c:url value='/FrontServlet?method=findAll&type=out'/>">校外活动</a></li>
							<li><a href="/Gx/ClubServlet?method=findAll">兴趣社区</a></li>
						</ul>
					</div>
					<div id="count">
						<img src="/Gx/adminjsps/img/account.png" height="33" width="33">
					</div>
					<div id="countinfo">
						<ul id="myul" class="">
							<li><a href="<c:url value='/UserServlet?method=reloadAccount'/>" style="text-decoration: none"> <i
									style="margin-top: 5px" class="fa  fa-rebel"></i> 我的主页
							</a></li>
							<li><a href="Logout.do" style="text-decoration: none"> <i
									style="margin-top: 5px" class="fa  fa-power-off"></i> 注 销
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</header>
	</div>
	<!-- header close -->
	<!-- content begin -->
	<div id="content" class="no-bottom no-top">
		<!-- section begin -->
		<div class="full-height dark no-padding dark" data-speed="5"
			data-type="background">
			<div class="de-video-container">
				<div class="de-video-content">
					<div class="text-center" style="font-size: 25px">
						我们的大学不仅如此，为什么不做出改变？
						<div class="spacer-single"></div>
						<div class="text-slider border-deco">
							<div class="text-item">
								Welcome To <span class="id-color">BISTU</span>
							</div>
							<div class="text-item">
								校内 + <span class="id-color">校外</span>
							</div>
							<div class="text-item">
								创意改变 <span class="id-color">生活</span>
							</div>
							<div class="text-item">
								<span class="id-color"><i class="icon-bike"></i></span><span
									class="id-color"> Ready to Crazy?</span>
							</div>
						</div>
						<div class="spacer-single"></div>
						<a href="#" class="btn btn-border btn-big">开始 Crazy</a>
					</div>
				</div>
				<div class="de-video-overlay"></div>
				<!-- load your video here -->
				<video autoplay="" loop="" muted="" poster="video/video-2.jpg">
					<source src="video/video-2.webm" type="video/webm" />
					<source src="video/video-2.mp4" type="video/mp4" />
					<source src="video/video-2.ogg" type="video/ogg" />
				</video>
			</div>
		</div>
		<!-- section close -->
	</div>
</body>

</html>
