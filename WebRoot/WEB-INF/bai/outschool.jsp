<%@page import="com.gx.entity.School"%>
<%@page import="com.gx.entity.Navigate"%>
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
<title>Cubic - 校外活动</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Responsive Minimal Bootstrap Theme">
<meta name="keywords"
	content="onepage,responsive,minimal,bootstrap,theme">
<meta name="author" content="">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<!--[if lt IE 9]>
	<script src="js/html5shiv.js"></script>
	<![endif]-->


<!-- CSS Files
    ================================================== -->
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">
<link rel="stylesheet" href="css/jpreloader.css" type="text/css">
<link rel="stylesheet" href="css/animate.css" type="text/css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<!-- custom style css -->
<link rel="stylesheet" href="css/custom-style.css" type="text/css">
<!-- color scheme -->
<link rel="stylesheet" href="css/color.css" type="text/css">
<!-- revolution slider -->
<link rel="stylesheet" href="rs-plugin/css/settings.css" type="text/css">
<link rel="stylesheet" href="css/rev-settings.css" type="text/css">
<link href="css/1.css" rel="stylesheet" type="text/css" />
<!-- load fonts -->
<link rel="stylesheet" href="fonts/font-awesome/css/font-awesome.css"
	type="text/css">
<link rel="stylesheet" href="css/count.css" type="text/css">
<!-- 自定义css,count样式 -->
<!-- Javascript Files
    ================================================== -->
<script src="js/jquery.min.js"></script>
<script src="js/jpreLoader.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.isotope.min.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<script src="js/easing.js"></script>
<script src="js/jquery.ui.totop.js"></script>
<script src="js/jquery.flexslider-min.js"></script>
<script src="js/jquery.scrollto.js"></script>
<script src="js/owl.carousel.js"></script>

<script src="js/classie.js"></script>
<script src="js/designesia.js"></script>

<!-- SLIDER REVOLUTION SCRIPTS  -->
<script type="text/javascript"
	src="rs-plugin/js/jquery.themepunch.plugins.min.js"></script>
<script type="text/javascript"
	src="rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
<script src="js/search.js"></script>
<!-- 自定义js -->
<script type="text/javascript">
	$(function() {
		$(".col-md-12").hover(function() {//内容太长,省略
			var str = $(this).children('p').eq(1).text().substr(0, 15);
			$(this).children('p').eq(1).text(str + "....");
		});
	});
</script>
</head>
<%
	List<Navigate> navlist = (List<Navigate>) request.getAttribute("navbeanList");
	Navigate[] navschool = new Navigate[4];
	for (int i = 0; i < navlist.size(); i++) {
		navschool[i] = navlist.get(i);
	}
	List<School> tuilist = (List<School>) request.getAttribute("tuibeanList");
	School[] tuischool = new School[4];
	for (int i = 0; i < 4; i++) {
		tuischool[i] = tuilist.get(i);
	}
%>
<body id="homepage">
	<div id="wrapper">
		<div class="page-overlay"></div>
		<!-- header begin -->
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
								id="q" name="q" autocomplete="off" value="" maxlength="280px"
								placeholder="搜索你感兴趣的内容..." type="text" /></span> <span><input
								id="searchimg" type="image" src="/Gx/adminjsps/img/search1.png"
								style="width: 40px; vertical-align: middle; margin-left: -4px; border-radius: 4px"
								onclick="search()" /></span>


							<ul id="mainmenu">
								<li><a href="Main.do">首页</a></li>
								<li><a
									href="<c:url value='/FrontServlet?method=findAll&type=in'/>">校内活动</a></li>
								<li><a class="active"
									href="<c:url value='/FrontServlet?method=findAll&type=out'/>">校外活动</a></li>
								<li><a href="/Gx/ClubServlet?method=findAll">兴趣社区</a></li>
							</ul>
						</div>
						<div id="count">
							<img src="/Gx/adminjsps/img/account.png" height="33" width="33">
						</div>
						<div id="countinfo">
							<ul id="myul" class="">
								<li><a
									href="<c:url value='/UserServlet?method=reloadAccount'/>"
									style="text-decoration: none"> <i style="margin-top: 5px"
										class="fa  fa-rebel"></i> 我的主页
								</a></li>
								<li><a href="Logout.do" style="text-decoration: none">
										<i style="margin-top: 5px" class="fa  fa-power-off"></i> 注 销
								</a></li>
							</ul>
						</div>
					</div>
				</div>
			</header>
		</div>

		<!-- revolution slider begin -->
		<div id="section-slider" class="fullwidthbanner-container">
			<div id="revolution-slider">
				<ul>
					<!--导航栏第一张图片 -->
					<c:forEach var="item" items="${navbeanList }">
						<li data-transition="fade" data-slotamount="10"
							data-masterspeed="200"
							data-thumb="images-slider/thumbs/thumb1.jpg"><img
							src="FrontServlet?method=navImage&filepath=${item.gtupian }"
							alt="" /> <c:if test="${item.gadv==1 }">
								<div class="tp-caption big-white sft" data-x="center"
									data-y="165" data-speed="800" data-start="400"
									data-easing="easeInOutExpo" data-endspeed="450">
									<div
										style="background-color: #ed008c; border-radius: 20px; color: rgb(248, 252, 255); height: 40px; line-height: 40px; text-align: center; width: 100px;">广告</div>
								</div>
							</c:if>

							<div class="tp-caption ultra-big-white customin customout start"
								data-x="center" data-y="center"
								data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:2;scaleY:2;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;"
								data-customout="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:0.85;scaleY:0.85;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;"
								data-speed="800" data-start="400" data-easing="easeInOutExpo"
								data-endspeed="400">
								<span>${item.gtheme }</span>
							</div>

							<div class="tp-caption sfb" data-x="center" data-y="325"
								data-speed="400" data-start="800" data-easing="easeInOutExpo">
								<c:if test="${item.gurl!='0'}">
									<a href="${item.gurl}" class="btn-slider" target="_blank">查看
									</a>
								</c:if>
								<c:if test="${item.gurl=='0'}">
									<a
										href="FrontServlet?method=navDetail&gid=${item.id }&type=nav"
										target="_blank" class="btn-slider">查看 </a>
								</c:if>

							</div></li>

					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- revolution slider close -->
		<!-- content begin -->
		<div id="content" class="no-bottom no-top content-overlay">
			<!-- team section begin -->
			<section id="section-team">
				<div class="container">
					<div class="row">
						<div class="col-md-6 col-md-offset-3 text-center">
							<div style="text-align: left">
								<h1 class="animated" data-animation="fadeInUp">
									最新<span class="id-color">活动</span> </br>
								</h1>
							</div>
							<div class="spacer-single"></div>
						</div>
						<span style="float: right; font-size: 15px; margin-right: 15px"><a
							href="FrontServlet?method=moreActive&type=out" target="_blank">更多最新</a></span>
					</div>
					<br> <br>
					<div class="row">
						<!-- team member -->
						<c:forEach var="item" items="${newbeanList }" varStatus="status">
							<c:if test="${status.index<4 }">
								<div class="de-team-list col-md-3 animated"
									data-animation="fadeInUp" data-delay="0">
									<div class="team-pic">
										<img
											src="FrontServlet?method=doImage&filepath=${item.gtupian}"
											alt="" height="263" width="263" />
									</div>
									<div class="team-desc col-md-12">
										<a target="_blank"
											href="FrontServlet?method=navDetail&gid=${item.id}&type=outschool"><h3>${item.gtheme}</h3></a>
										<p class="lead">${item.gpart }</p>
										<div class="small-border"></div>
										<p>${item.gcontent }</p>
										<div class="social">
											<a href="#"><i class="fa fa-facebook fa-lg"></i></a> <a
												href="#"><i class="fa fa-twitter fa-lg"></i></a> <a href="#"><i
												class="fa fa-google-plus fa-lg"></i></a> <a href="#"><i
												class="fa fa-skype fa-lg"></i></a>
										</div>
									</div>
								</div>
							</c:if>
							<!-- team close -->
						</c:forEach>


						<div class="clearfix"></div>

					</div>
					<br> <br> <br> <br>
					<div class="row">
						<div class="col-md-6 col-md-offset-3 text-center">
							<div style="text-align: left">
								<h1 class="animated" data-animation="fadeInUp">
									推荐<span class="id-color">活动</span> </br>
								</h1>
							</div>
							<div class="spacer-single"></div>
						</div>
						<span style="float: right; font-size: 15px; margin-right: 15px"><a
							href="FrontServlet?method=moreActive&type=outtui" target="_blank">更多推荐</a></span>
					</div>
					<div class="row">
						<!-- team member -->
						<c:forEach var="item" items="${tuibeanList }" varStatus="status">
							<c:if test="${status.index<4 }">
								<div class="de-team-list col-md-3 animated"
									data-animation="fadeInUp" data-delay="0">
									<div class="team-pic">
										<img
											src="FrontServlet?method=doImage&filepath=${item.gtupian }"
											alt="" height="263" width="263" />
									</div>
									<div class="team-desc col-md-12">
										<a target="_blank"
											href="FrontServlet?method=navDetail&gid=${item.id }&type=outtuijian"><h3>${item.gtheme}</h3></a>
										<p class="lead">${item.gpart }</p>
										<div class="small-border"></div>
										<p>${item.gcontent }</p>

										<div class="social">
											<a href="#"><i class="fa fa-facebook fa-lg"></i></a> <a
												href="#"><i class="fa fa-twitter fa-lg"></i></a> <a href="#"><i
												class="fa fa-google-plus fa-lg"></i></a> <a href="#"><i
												class="fa fa-skype fa-lg"></i></a>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>

						<div class="clearfix"></div>

					</div>
					<br> <br>
				</div>
			</section>
			<!-- section close -->
			<%@include file="/adminjsps/foot.jsp"%>
		</div>
	</div>



</body>
</html>
