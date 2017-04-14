<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- Javascript Files-->
<script src="js/jquery.min.js"></script>
<script src="js/jpreLoader.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<!-- <script src="js/jquery.ui.totop.js"></script> -->
<script src="js/owl.carousel.js"></script>
<script src="js/classie.js"></script>
<script src="js/designesia.js"></script>
<script src="js/search.js"></script>
<script src="js/validation-user.js"></script>
<style type="text/css">
#mainmenu a {
	color: #333;
}

.divv {
	font-size: 20px;
	margin: 0 20px 20px 0;
	padding-left: 400px;
	padding-top: 20px;
}

.divv span {
	margin: 0 1px 1px 0;
}

.divv input {
	width: 250px;
}

.well {
	background-color: #51a351;
	border: 1px solid #e3e3e3;
	border-radius: 4px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
	margin-bottom: -200px;
	margin-top: 55px;
	min-height: 20px;
	padding: 19px;
	text-align: center;
	border: 1px solid #e3e3e3;
}
</style>

<script type="text/javascript">
	$(function() {
		if ($("#msg").val() == "isexist") {
			document.getElementById("egname").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **该用户名已存在！</span>";
		}
		if ($("#succflag").val() == "1") {
			$("#succ").show().delay(6000).hide(0);
		}
	});
	function showPass() {
		$("#showPass").toggle();
	}
	function judge() {
		var u = document.getElementById("gusername").value;
		if (u == "") {
			document.getElementById("egname").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写用户名！</span>";
			$("#egname").show().delay(3000).hide(0);
			return false;
		} else {
			if ($("#showPass").css("display") == 'block') {
				var q = document.getElementById("gpass").value;
				if (q == "") {
					document.getElementById("egpass").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写原密码！</span>";
					$("#egpass").show().delay(3000).hide(0);
					return false;

				} else if (q !=
<%=session.getAttribute("pwd")%>
	) {
					document.getElementById("egpass").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **密码错误，请重新输入！</span>";
					$("#egpass").show().delay(3000).hide(0);
					return false;
				} else {
					document.getElementById("egpass").innerHTML = "";
				}
				var w = document.getElementById("gpwd").value;
				if (w == "") {
					document.getElementById("egnewid").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写新密码！</span>";
					$("#egnewid").show().delay(3000).hide(0);
					return false;
				} else if (w.length > 20 || w.length < 6) {
					document.getElementById("egnewid").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **密码长度错误，请重新输入！</span>";
					$("#egnewid").show().delay(3000).hide(0);
					return false;
				} else {
					document.getElementById("egnewid").innerHTML = "";
				}

				var e = document.getElementById("gnewids").value;
				if (e == "") {
					document.getElementById("egnewids").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请确认新密码！</span>";
					$("#egnewids").show().delay(3000).hide(0);
					return false;
				} else if (e != w) {
					document.getElementById("egnewids").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **两次密码不一样，请重新输入！</span>";
					$("#egnewids").show().delay(3000).hide(0);
					return false;
				} else {
					document.getElementById("egnewids").innerHTML = "";
				}
			}
		}
	}
</script>
</head>
<body>
	<%-- <c:if test="${sessionScope.level!=1}"> --%>
	<div id="wrapper">
		<input id="getqu" type="text" style="display: none" value=${question}>
		<div class="page-overlay"></div>
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
							<li><a class="active" href="Main.do">首页</a></li>
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
							<li><a href="#" style="text-decoration: none"> <i
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

	<div
		style="background-image: url(images/background/body.png); padding: 150px 90px 0px;">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span9">
					<div class="row-fluid">
						<div class="page-header">
							<h1>
								个人账户信息 <small style="color: #ED008C; cursor: pointer;"
									onclick="showPass()">修改账号密码?</small>
							</h1>
							<input id="succflag" type="hidden" value="${succflag}" />
							<div style="display: none" id="succ">
								<img alt="" src="adminjsps/img/succ.png" height="20px"
									width="20px">账户信息修改成功
							</div>
						</div>
						<form onsubmit="return judge()" style="background-color: white"
							action="<c:url value='/UserServlet?method=editAccount&gid=${gid}'/>"
							method="post">
							<div class="divv">
								<input id="msg" type="hidden" value="${msg}" /> <span>
									用户名: <input type="text" id="gusername" name="gusername"
									value="${user.gusername }" />
								</span> <span id="egname"></span>
							</div>
							<div class="divv">
								<span> 邮&nbsp&nbsp&nbsp&nbsp&nbsp箱:<input type="text"
									id="gmail" name="gmail" value="${user.gmail }" />
								</span> <span id='email_error' class='error'>邮箱格式不正确!</span>
							</div>
							<div class="divv">
								<span> 手&nbsp&nbsp&nbsp&nbsp&nbsp机:<input type="text"
									id="gtel" name="gtel" value="${user.gtel }" />
								</span> <span id="egtel"></span><span id='tel_error' class='error'>电话号码格式不正确!</span>
							</div>
							<div id="showPass" style="display: none">
								<hr
									style="height: 3px; border: none; border-top: 3px double red;" />
								<div class="divv">
									<span> 原&nbsp&nbsp密&nbsp&nbsp码:<input type="password"
										id="gpass" name="gpass" value="" />
									</span> <span id="egpass"></span>
								</div>
								<div class="divv">
									<span> 新&nbsp&nbsp密&nbsp&nbsp码:<input type="password"
										id="gpwd" name="gpwd" placeholder="6~12位,区分大小写" />
									</span> <span id="egnewid"></span>
								</div>
								<div class="divv">
									<span> 确认密码:<input type="password" id="gnewids"
										name="gnewids" />
									</span> <span id="egnewids"></span>
								</div>
							</div>
							<div class="form-actions"
								style="text-align: center; padding-bottom: 20px">
								<input type="submit" class="btn btn-success btn-large"
									id="send_message" value="Save Changes" id="tj" /> <a
									class="btn" href="Main.do">Cancel</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<%@include file="/adminjsps/foot.jsp"%>
	</div>
	<%-- </c:if>
	<c:if test="${sessionScope.level==1}">
		<h1 style="text-align: center">请去管理员后台操作!</h1>
	</c:if> --%>
</body>
</html>
