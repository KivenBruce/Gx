<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN" class="no-js topic-pages">
<head>
<meta charset="utf-8" />
<title>Cubic-话题广场</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="css/zhihu.css">
<script src="js/zhihu.js"></script>
<style type="text/css">
.zh-general-list {
	display: none;
}

#in {
	height: 16px;
	margin-left: 115px;
	margin-top: -3px;
	width: 16px;
}
.well {
	background-color: #51a351;
	border: 1px solid #e3e3e3;
	border-radius: 4px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
	margin-bottom: -60px;
	min-height: 20px;
	padding: 19px;
	text-align: center;
	border: 1px solid #e3e3e3;
}
.FeedbackButton-button-3waL{
display: none;
}
</style>
</head>
<body class="zhi ">
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

	<div class="zg-wrap zu-main clearfix " role="main">
		<!-- content -->
		<div class="zu-main-content">
			<div class="zu-main-content-inner">
				<div class="zm-topic-cat-page">
					<div class="zm-topic-cat-title">
						<a href="javascript:;" class="zg-link-gray zg-right"> <span
							id="focusNum">已关注${focusNum}个话题</span>
						</a>
						<h2>
							<i class="fa fa-globe"></i>话题广场
						</h2>
					</div>
					<!-- 所有父club标签 -->
					<ul class="zm-topic-cat-main clearfix">
						<li class="zm-topic-cat-item" data-id="255"><a
							href="/Gx/ClubServlet?method=findAll">所有</a></li>

						<li class="zm-topic-cat-item" data-id="254"><a
							href="/Gx/ClubServlet?method=findAll&parentid=1">游戏</a></li>

						<li class="zm-topic-cat-item" data-id="833"><a
							href="/Gx/ClubServlet?method=findAll&parentid=2">运动</a></li>

						<li class="zm-topic-cat-item" data-id="99"><a
							href="/Gx/ClubServlet?method=findAll&parentid=3">互联网</a></li>

						<li class="zm-topic-cat-item" data-id="988"><a href="#教育">教育</a></li>

						<li class="zm-topic-cat-item" data-id="388"><a href="#摄影">摄影</a></li>

						<li class="zm-topic-cat-item" data-id="444"><a href="#旅行">旅行</a></li>

						<li class="zm-topic-cat-item" data-id="1537"><a href="#职业发展">职业发展</a></li>

						<li class="zm-topic-cat-item" data-id="3324"><a href="#经济学">经济学</a></li>

						<li class="zm-topic-cat-item" data-id="75"><a href="#音乐">音乐</a></li>

						<li class="zm-topic-cat-item" data-id="68"><a href="#电影">电影</a></li>


						<li class="zm-topic-cat-item" data-id="112"><a href="#创业">创业</a></li>

						<li class="zm-topic-cat-item" data-id="2143"><a href="#科技">科技</a></li>

						<li class="zm-topic-cat-item" data-id="19800"><a href="#金融">金融</a></li>

					</ul>
					<div class="zm-topic-cat-sub">
						<div class="zh-general-list clearfix">
							<c:forEach var="item" items="${ pb.beanList}">
								<div class="item">
									<div class="blk">
										<a id="detail" target="_blank" style="cursor: pointer;"> <img
											src="ClubServlet?method=doImage&filepath=${item.club_image}&parentid=${item.parent_id}"
											alt="${item.club_name}"> <strong>${item.club_name}</strong>
										</a>
										<c:if test="${item.gflag==0}">
											<img id="in" title="校内club" src="xiaodao/img/star.png">
										</c:if>
										<c:forEach var="keys" items="${mapcount }">
											<c:if test="${item.club_id==keys.key}">
												<div
													style="margin-bottom: 6px; margin-left: 95px; margin-top: -26px; color: #9999b3;">
													<span id="${item.club_id}">${keys.value} </span>人已关注
												</div>
											</c:if>
										</c:forEach>

										<p>${item.club_desc}</p>
										<a id="t::-${item.club_id}" href="javascript:;"
											class="follow meta-item zg-follow"><i
											class="z-icon-follow"></i> <c:if
												test="${!fn:contains(flist,item.club_id)}">关注</c:if> <c:if
												test="${fn:contains(flist,item.club_id)}">取消关注</c:if></a> <input
											id="isfo" type="hidden" value="${item.isfocus}" /> <input
											id="isfo" type="hidden" value="${userid}" /> <input
											id="isfo" type="hidden" value="${item.club_id }" />
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

		</div>

		<!-- 热门话题 -->
		<div class="zu-main-sidebar" data-za-module="RightSideBar">
			<div class="zm-side-section explore-side-section">
				<div class="zm-side-section-inner">
					<div class="section-title">

						<h3>热门话题</h3>
					</div>
					<ul class="list hot-topics">
						<c:forEach var="hotitem" items="${ hotpb.beanList}">
							<li class="clearfix"><a target="_blank" class="avatar-link"
								href="javascript:;"><img
									src="ClubServlet?method=doImage&filepath=${hotitem.club_image}&parentid=${hotitem.parent_id}"
									class="avatar 40" /></a>
								<div class="content">
									<a href="/Gx/ClubServlet?method=clubDetail&clubid=${hotitem.club_id}" target="_blank">${hotitem.club_name}</a>
									<div class="meta">
										<c:forEach var="keys" items="${mapcount }">
											<c:if test="${hotitem.club_id==keys.key}">
												<div
													style="color: #9999b3;">
													<span id="${item.club_id}">${keys.value} </span>人关注
												</div>
											</c:if>
										</c:forEach>

									</div>
								</div>
								<div class="bottom">

									<a class="question_link" href="/Gx/ClubServlet?method=clubDetail&clubid=${hotitem.club_id}" target="_blank">
										${fn:substring(hotitem.club_desc,0,40)}</a>

								</div></li>
						</c:forEach>

					</ul>
				</div>
			</div>
		
		<div style="margin-left: -900px; margin-top: 90px;width: 1365px;">
	    <%@include file="/adminjsps/foot.jsp"%>
	    </div>
		
		</div>
		
	</div>
			
	<script src="js/jquery.min.js"></script>
	<script src="js/zhihu/club.js"></script>
	<script src="js/zhihu/zhihu1.js"></script>
	<script src="js/zhihu/zhihu2.js"></script>
	<script src="js/zhihu/zhihu3.js"></script>
	<script src="js/zhihu/zhihu4.js" async></script>
	<script src="js/zhihu/zhihu5.js"></script>
	<meta name="entry" content="ZH.entryTS" data-module-id="page-misc">
</body>

</html>