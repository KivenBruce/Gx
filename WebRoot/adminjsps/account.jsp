<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<title>Cubic - 个人中心页</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link rel="stylesheet" type="text/css" href="xiaodao/user.css">
<link rel="stylesheet" href="css/zhihu.css">
<link href="fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<script src="js/zhihu.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/validation-user.js"></script>
<script type="text/javascript">
	function judgePass() {
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
			document.getElementById("egnewids").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **两次密码不一样！</span>";
			$("#egnewids").show().delay(3000).hide(0);
			return false;
		} else {
			document.getElementById("egnewids").innerHTML = "";
			$.ajax({											
				type: "POST",
				dataType:"json",
				url:'/Gx/UserServlet?method=editAccount&gid='+${gid},
				data:$('#passinfo').serialize(),// 你的formid
				async: false,
				error: function(request) {
					alert("Connection error");
				},
				success: function(data) {
					alert(data.info);												
				}
			});
		}
	}
</script>
<style type="text/css">
#userinfo {
	font-size: 20px;
	margin-left: 20px;
	padding-top: 15px;
}

.divv {
	padding-top: 5px;
}

.divv input {
	color: #997777;
	font-size: 18px;
	margin-left: 10px;
	width: 250px;
}

.error {
	padding-left: 22px;
	color: #FF0033;
	display: none;
}

.notice {
	cursor: pointer;
	background-color: #ff634f;
	line-height: 18px;
	text-align: center;
	color: #fff;
	width: 60px;
	position: absolute;
	margin-left: 10px;
}

</style>
</head>
<body style="margin-top: 50px; background-color: #f0f0f0;">
	<!-- header -->
	<div role="navigation" class="zu-top" data-za-module="TopNavBar">
		<div class="zg-wrap modal-shifting clearfix" id="zh-top-inner">
			<div class="top-nav-profile">
				<a href="javascript:;" class="zu-top-nav-userinfo "> <span
					class="name"><%=session.getAttribute("name")%></span> <img
					class="Avatar" src="adminjsps/img/account.png" /> <span
					id="zh-top-nav-new-pm" class="zg-noti-number zu-top-nav-pm-count"
					style="visibility: hidden" data-count="0"> </span>
				</a>
				<ul class="top-nav-dropdown" id="top-nav-profile-dropdown">
					<li><a href="/Gx/UserServlet?method=reloadAccount"> <i
							class="fa fa-home"></i>我的主页
					</a></li>
					<li><a href="Logout.do"> <i class="fa  fa-power-off"></i>退出
					</a></li>
				</ul>

			</div>
			<!-- 搜索栏 -->
			<div class="searchclub">
				<form class="search-form">
					<input type="text" class="search-input" id="question"
						autocomplete="off" value="" maxlength="100"
						placeholder="搜索你感兴趣的内容...">
					<button id="search" onclick="searchclub()" class="club-button"
						type="submit"></button>
				</form>
			</div>



			<div id="zg-top-nav" class="zu-top-nav">
				<ul class="zu-top-nav-ul zg-clear">

					<li class="zu-top-nav-li " id="zh-top-nav-home"><a
						class="zu-top-nav-link" href="Main.do" id="zh-top-link-home"
						data-za-c="view_home" data-za-a="visit_home"
						data-za-l="top_navigation_home">首页</a></li>



					<li class="top-nav-topic-selector zu-top-nav-li "
						id="zh-top-nav-topic"><a class="zu-top-nav-link"
						href="<c:url value='/FrontServlet?method=findAll&type=in'/>"
						id="top-nav-dd-topic">校内活动</a></li>

					<li class="zu-top-nav-li " id="zh-top-nav-explore"><a
						class="zu-top-nav-link"
						href="<c:url value='/FrontServlet?method=findAll&type=out'/>">校外活动</a></li>

					<li class="top-nav-noti zu-top-nav-li "><a
						class="zu-top-nav-link" href="/Gx/ClubServlet?method=findAll"
						id="zh-top-nav-count-wrap" role="button"><span
							class="mobi-arrow"></span>兴趣社区</a></li>
				</ul>
			</div>

		</div>
	</div>
	<!-- container -->
	<div class="container">
		<!-- 头像 -->
		<div class="ui-user-menu" id="userMenu">
			<div class="user-menu">
				<a href="#"><img id="userimage"
					src="ClubServlet?method=doImage&filepath=${user.gimage}" alt=""
					width="70" height="70"></a>
				<p class="name">${user.gusername }</p>

				<ul class="sns-menu-list">
					<li class="menu menu-item" data-hash="friends">我的关注
						<span id="focuscount" >${fn:length(pb.beanList)}</span></li>
					<li class="menu menu-item" data-hash="follow">我的点赞
						${likecount}</li>
					<li class="menu menu-item last" data-hash="follower">我的评论
						${commentCount}</li>
				</ul>
			</div>
			<ul class="content-menu">
				<li class="menu menu-item active" id="i1">我的club</li>
				<li class="menu menu-item" id="i2">我的信息</li>
				<li class="menu menu-item" id="i3">密码管理</li>
			</ul>
		</div>
		<!-- 我的club -->
		<div class="ui-user-item" id="q1" style="display: block">
			<h2>我关注的Club</h2>

			<div class="ui-body">
				<div class="content">
					<ul class="user-org-list clearfix">
						<c:forEach var="item" items="${pb.beanList }">
							<li><a class="avatar" href="javascript:;"> <img
									src="ClubServlet?method=doImage&filepath=${item.club_image}&parentid=${item.parent_id}"
									alt="">
							</a>
								<dl>
									<dt>
										<a
											href="/Gx/ClubServlet?method=clubDetail&clubid=${item.club_id}"
											target="_blank">${item.club_name}</a> 
											<span class="notice" style="line-height: 18px">取消关注</span>
											<input  type="hidden" value="${gid}" />
											<input  type="hidden" value="${item.club_id}" />
									</dt>
									<dd>
										<c:forEach var="keys" items="${clubFocusCount}">
											<c:if test="${keys.key==item.club_id}">
												<span id="focusnull">已有:${keys.value} 人关注</span>
											</c:if>
										</c:forEach>
										<span>来自:${item.club_parent}</span>
									</dd>
								</dl></li>
						</c:forEach>
					</ul>

				</div>
			</div>

		</div>
		<!-- 我的信息 -->
		<div class="ui-user-item" id="q2">
			<h2>我的信息</h2>
			<form onsubmit="return judge()" style="background-color: white"
				action="javascript:;" id="userform" method="post">
				<div id="userinfo">
					<div class="divv">
						<span> 用户名 :<input type="text" id="gusername"
							name="gusername" value="${user.gusername }" />
						</span> <span id="egname"></span>
					</div>
					<div class="divv">
						<span> 邮&nbsp&nbsp&nbsp&nbsp&nbsp箱:<input type="text"
							id="gmail" name="gmail" value="${user.gmail }" />
						</span> <span id='email_error' class='error'>**邮箱格式不正确!</span>
					</div>
					<div class="divv">
						<span> 手&nbsp&nbsp&nbsp&nbsp&nbsp机:<input type="text"
							id="gtel" name="gtel" value="${user.gtel }" />
						</span><span id='tel_error' class='error'>**电话号码格式不正确!</span>
					</div>
					<div class="divv">
						<span> 头&nbsp&nbsp&nbsp&nbsp&nbsp像:<input type="file"
							id="gimage" name="gimage" value="${user.gimage }" />
						</span>
					</div>
					<div class="divv">
						<span> 签&nbsp&nbsp&nbsp&nbsp&nbsp名:<input type="text"
							id="gtitle" name="gtitle" value="${user.gtitle }" />
						</span> <span id="etitle"></span>
					</div>
					<div class="form-actions"
						style="margin-left: 10px; margin-top: 20px; padding-bottom: 10px;">
						<input type="submit" class="btn btn-success btn-large"
							id="send_message" value="保存修改" id="tj" /> <input id="gid"
							type="hidden" value="${gid}">
						<!-- <button onclick="window.history.back()"
							style="border: 1px solid #31c37c; border-radius: 8px; color: #ed008c; font-size: 13px; height: 30px; width: 40px;">取
							消</button> -->
					</div>
				</div>
			</form>
		</div>

		<!-- 密码管理 -->
		<div class="ui-user-item" id="q3">
			<h2>密码管理</h2>
			<form onsubmit="return judgePass()" style="background-color: white"
				id="passinfo" action="javascript:;" method="post">
				<div class="ui-body">
					<div id="userinfo">
						<div class="divv">
							<span> 新&nbsp&nbsp密&nbsp&nbsp码:<input type="password"
								id="gpwd" name="gpwd" placeholder="6~12位,区分大小写" />
							</span> <span id="egnewid"></span>
						</div>
						<div class="divv">
							<span> 确认密码: <input type="password" id="gnewids"
								style="margin-left: 7px" name="gnewids" />
							</span> <span id="egnewids"></span>
						</div>
						<div class="form-actions"
							style="margin-left: 10px; margin-top: 20px; padding-bottom: 10px;">
							<input type="submit" class="btn btn-success btn-large"
								id="send_newpwd" value="保存修改" id="tj" />
							<!-- <button onclick="window.history.back()"
								style="border: 1px solid #31c37c; border-radius: 8px; color: #ed008c; font-size: 13px; height: 30px; width: 40px;">取
								消</button> -->
						</div>
					</div>
				</div>
			</form>
		</div>

	</div>
	<!-- footer -->
	<div style="bottom: 60px; position: fixed; width: 100%">
		<%@include file="/adminjsps/foot.jsp"%>
	</div>

</body>
</html>
