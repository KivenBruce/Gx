<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta charset="utf-8" />
<title>Cubic-话题详情</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="css/zhihu.css">
<link rel="stylesheet" href="xiaodao/xiaodao.css">
<script src="js/jquery.min.js"></script>
<script src="js/zhihu.js"></script>
<script src="js/zhihu/club.js"></script>
<script src="js/zhihu/comment.js"></script>
<script type="text/javascript" charset="utf-8"
	src="uedit/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="uedit/ueditor.all.min.js"></script>
<style type="text/css">
.zh-general-list {
	display: none;
}

.well {
	background-color: #51a351;
	border: 1px solid #e3e3e3;
	border-radius: 4px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
	margin-bottom: -20px;
	min-height: 20px;
	padding: 19px;
	text-align: center;
	border: 1px solid #e3e3e3;
}

.FeedbackButton-button-3waL {
	display: none;
}
</style>
<script type="text/javascript">
	function jumpToPage() {
		var jumppage = document.getElementById("showPage").value;

		if (jumppage == "") {
			alert("Error!请输入页码");
			return;
		}
		if (isNaN(jumppage)) {
			alert("Error!请输入数字页码");
			return;
		}
		if (jumppage != "" && jumppage < 1) {
			alert("Error!请输入正常数字范围的页码");
			return;
		}
		if (jumppage > '${commentList.pageCount}') {
			alert("Error: 输入的页码超过总页数，请重新输入！");
			return;
		}
		window.location = "/Gx/ClubServlet?method=clubDetail&curPage="
				+ jumppage + "&clubid=${clubid }";
		/* $('body').load(
				"/Gx/ClubServlet?method=clubDetail&curPage=" + jumppage+"&clubid=${clubid }"); */
	}
	/* $(function(){
		$("#user_id").val(${userid});
		$("#club_id").val(${clubid});
	}); */
</script>
</head>
<body class="zhi ">
	<!-- head -->
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
	<!-- body -->
	<div class="ui-community-header " id="communityHeader">
		<div class="ui-community-banner">
			<img src="xiaodao/img/banner-3a0ac30.png" alt="" width="100%">
		</div>
		<div class="ui-community-box">
			<div class="ui-community-log">
				<img class="img_layze" alt=""
					src="ClubServlet?method=doImage&filepath=${club.club_image}&parentid=${club.parent_id}">
			</div>
			<!-- title -->
			<div class="ui-community-detail">
				<h4>
					<b>${club.club_name}</b>
					<c:if test="${club.isfocus==0}">
						<span class="notice-btn ui-notice" style="cursor: pointer;">关注</span>
					</c:if>
					<c:if test="${club.isfocus==1}">
						<span class="notice-btn ui-notice" style="cursor: pointer;">取消关注</span>
					</c:if>
					<input id="isfo" type="hidden" value="${club.isfocus}" /> <input
						id="isfo" type="hidden" value="${userid}" /> <input
						id="isfo" type="hidden" value="${club.club_id }" />
				</h4>
				<p>
					<span class="pagingCount">${clubCount}</span>人关注了这个club
				</p>
				<p class="ui-owner">来自：${club.club_parent }</p>
			</div>
		</div>
	</div>
	<div class="ui-community-content " id="communityCont">
		<!-- 动态列表 foreach-->
		<div class="ui-dynamic-list">
			<h4 class="status-box">社团动态</h4>

			<ul class="status-list">
				<c:choose>
					<c:when
						test="${commentList.getPageCount()!=0 and commentList.getPageCount()!=''}">
						<c:forEach var="item" items="${commentList.beanList}" varStatus="cstatus">
							<c:forEach var="likeitem" items="${likeList}" varStatus="lstatus">
							<c:if test="${cstatus.index==lstatus.index }">
								<li class="ui-status-list ui-habit-status" id="${item.id}">
									<div class="ui-oper-info">
										<div class="ui-oper-logo">
											<a href="javascript:;"> <img
												src="ClubServlet?method=doImage&filepath=${item.gimage}"
												alt="">
											</a>
										</div>
										<div class="ui-oper-data">
											<h3>
												<a href="javascript:;"><b>${item.user_name}</b></a>
											</h3>
											<p>${item.gtitle}</p>
										</div>

									</div>
									<div class="ui-dynamic-content statusContent">
										<div class="ui-dynamic-text">
											<p>${item.content}</p>
										</div>

									</div>
									<div class="ui-dynimic-comment">
										<span>${item.comment_time}</span>
										<div class="ui-action-box">
											<a href="javascript:;"> <c:if test="${likeitem=='0'}">
													<em class="ui-like liked "></em>
												</c:if> <c:if test="${likeitem=='1'}">
													<em class="ui-like"></em>
												</c:if> <b>${item.like_count}</b>
											</a> <input value="${item.id}" style="display: none" />
										</div>
										<c:if test="${sessionScope.userid==item.user_id}">
											<div class="ui-action">
												<span class="icon"></span>
												<ul class="ui-action-content">
													<li onclick="confirmDelete(${item.id})"class="report-status-btn">删除</li>
												</ul>
											</div>
										</c:if>

									</div>
								</li>
							</c:if>
								
							</c:forEach>
						</c:forEach>
					</c:when>

					<c:otherwise>
						<div style="text-align: center; line-height: 6; height: 120px">
							<h1>这个club还没有任何相关动态~~~~</h1>
						</div>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
						<br>
					</c:otherwise>
				</c:choose>
			</ul>
			<!-- 分页 -->
			<c:if
				test="${commentList.getPageCount()!=0 and commentList.getPageCount()!=''}">
				<div style="margin-top: 45px; margin-bottom: 50px">
					<tr>
						<td class="datatable-paging-info" colspan="5"><span
							style="margin-left: 20px" class="datatable-paging-count">
								第 <span>${curPage}</span> 页/共 <span>${commentList.pageCount}</span>
								页
						</span> <span class="datatable-paging-total" style="margin-left: 20px">
								总共 <span>${commentList.tr}</span> 条数据
						</span></td>

						<td><span style="float: right; margin-right: 15px;"> <c:if
									test="${curPage>1}">
									<span class="datatable-paging-first"></span>
									<span><a
										href="/Gx/ClubServlet?method=clubDetail&clubid=${clubid }">首页</a></span>
									<span class="datatable-paging-previous"></span>
									<span style="margin-right: 7px;"><a
										href="/Gx/ClubServlet?method=clubDetail&curPage=${curPage-1}&clubid=${clubid }">上一页</a></span>
								</c:if> <span style="margin-left: 7px;"><a
									href="/Gx/ClubServlet?method=clubDetail&curPage=${curPage+1}&clubid=${clubid }">下一页</a></span>
								<span class="datatable-paging-next"></span> <span><a
									href="/Gx/ClubServlet?method=clubDetail&curPage=${commentList.getPageCount()}&clubid=${clubid }">尾页</a></span><span
								class="datatable-paging-last"></span> <span
								style="margin-left: 7px;">跳转到：</span> <span
								style="text-align: center;"><input id="showPage"
									type="text"
									style="width: 30px; height: 20px; vertical-align: middle;" /></span>
								<span><input type="image"
									src="<%=basePath%>/adminjsps/img/go.gif"
									style="width: 30px; height: 20px; border-radius: 4px; vertical-align: middle;"
									onclick="jumpToPage()" /></span>
						</span></td>
					</tr>
				</div>
			</c:if>
			<!-- 发布动态 -->
			<form onsubmit="return judge()"
				action="<c:url value='/ClubServlet?method=addComment&clubid=${clubid}'/>"
				method="post">
				<div class="ui-pubish-status">
					<h4>
						<span>发布动态</span>
					</h4>
					<div class="ui-status-content">
						<span>内容</span>
						<div class="input ui-input-box">
							<script id="editor" type="text/plain"></script>
						</div>
						<div style="display: none">
							<input id="content" name="content" value="${content}" /> <input
								id="user_id" name="user_id" value="${userid}" /> <input
								id="club_id" name="club_id" value="${clubid}" /> <input
								id="user_name" name="user_name"
								value="<%=session.getValue("name")%>" />
						</div>
					</div>

					<div class="ui-publish-btn">
						<button class="ui-send-btn" type="submit">发布</button>
						<font size="2px;" style="margin-left: 10px">提示：请不要恶意灌水！谢谢！</font>
						<span class="ui-send-success">发布成功</span>
					</div>
				</div>
			</form>
		</div>

		<div class="ui-content-right" id="contentRight">
			<div class="ui-publish-status" data-href="#orgText">
				<i class="i-add"></i><a href="javascript:scroll(1200,1200)"
					style="text-decoration: none; color: #FFFFFF">发布动态</a>
			</div>
			<!-- 社团资料 -->
			<div class="ui-community-info">
				<h4>Club资料</h4>
				<p>
					<b>Club管理员：</b>${club.club_hoster}
				</p>
				<p>
					<b>Club分类：</b>${club.club_parent}
				</p>
				<p>
					<b>Club简介：</b> ${club.club_desc}

				</p>
			</div>
		</div>
	</div>
	<!-- 3个导航 -->
	<div class="ui-float-bar " id="floatBar"
		style="margin-left: 1220px; margin-bottom: 140px;">
		<ul>
			<li class="publish"><span><a
					href="javascript:scroll(1200,1200)"
					style="text-decoration: none; color: #FFFFFF">发布动态</a></span></li>
			<li class="refresh"><span><a
					href="javascript:window.location.reload()"
					style="text-decoration: none; color: #FFFFFF">刷新</a></span></li>
			<li class="top"><span><a href="javascript:scroll(0,0)"
					style="text-decoration: none; color: #FFFFFF">返回顶部</a> </span></li>
		</ul>
	</div>

	<div class="container-fluid">
		<%@include file="/adminjsps/foot.jsp"%>
	</div>

	<script type="text/javascript">
		UEDITOR_CONFIG.UEDITOR_HOME_URL = './uedit/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息 
		var editor = UE.getEditor('editor');
	</script>
</body>
</html>
