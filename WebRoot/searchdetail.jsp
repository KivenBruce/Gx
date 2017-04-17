<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/adminjsps/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cubic - One Page Responsive HTML 5 Website Template</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link rel="stylesheet" type="text/css" href="../css/detail.css">
<style>
#mainmenu  a {
	color: #333;
}
</style>
</head>
<body style="background-image: url(../images/background/body.png);">
	<div class="ui-detail-header " id="detailheader">
		<div class="ui-header-content">
			<div class="ui-content-img">
				<img src="<%=path %>/FrontServlet?method=doImage&filepath=${school.gtupian}" alt=""
					width="214" height="318">
			</div>
			<div class="ui-content-detail">
				<div class="ui-detail-top">
					<h4>${school.gtheme }</h4>
					<p>
						<b>时间：</b>${school.gtime}
					</p>
					<p>
						<b>地址：</b>${school.gplace}
					</p>
				</div>
				<div>
					<p>
						<b>活动人数：</b>${school.gperson }
					</p>
					<c:if test="${school.gprice==0 }">
						<p>
							<b>活动价格：</b> 免费

						</p>
					</c:if>

					<c:if test="${school.gprice!=0 }">
						<p>
							<b>活动价格：</b> ${school.gprice}
						</p>
					</c:if>
					<!--  -->
				</div>
				<div class="ui-detail-btn"></div>
			</div>
		</div>
	</div>
	<div class="ui-detail-content " id="detailContent">
		<div class="ui-publisher ui-template">
			<div class="ui-publisher-title ui-template-title">
				<h5>发布者</h5>
			</div>
			<div class="ui-publisher-info ui-template-info">
				<img
					src="<%=path %>/myschool.png"
					alt="" class="ui-publisher-logo">
				<div class="ui-publisher-name">${school.gpart}</div>
			</div>
		</div>
		<div class="ui-activity-detail">
			<div class="ui-activity-title">
				<h5>活动详情</h5>
			</div>
			<div class="ui-activity-content">${school.gcontent }</div>
		</div>
	</div>

	<%@include file="/adminjsps/foot.jsp"%>
</body>
</html>
