<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/adminjsps/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD jsp 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<title>Admin | Strass</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Admin panel developed with the Bootstrap from Twitter.">
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/site.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
</head>
<body>
	<c:if test="${sessionScope.level==1}">
		<%@include file="/adminjsps/head.jsp"%>
		<div class="container-fluid">
			<div class="row-fluid">
				<%@include file="/adminjsps/left.jsp"%>
				<div class="span9">
					<div class="well hero-unit">
						<h1>
							Welcome,<%=session.getAttribute("name")%></h1>
						<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
							Etiam eget ligula eu lectus lobortis condimentum. Aliquam nonummy
							auctor massa. Pellentesque habitant morbi tristique senectus et
							netus et malesuada fames ac turpis egestas.</p>
						<p>
							<a class="btn btn-success btn-large"
								href="<c:url value='/UserServlet?method=findAll'/>">Manage
								Users &raquo;</a>
						</p>
					</div>
					<div>
						<div style="float: left">
							<h3>访客总量</h3>
							<p>
								<a href="stats.jsp" class="badge badge-inverse"
									style="margin-left: 22px"><%=session.getAttribute("allv")%></a>
							</p>
						</div>
						<div style="float: left; margin-left: 100px">
							<h3>今日访客</h3>
							<p>
								<a href="stats.jsp" class="badge badge-inverse"
									style="margin-left: 22px"><%=session.getAttribute("todayv")%></a>
							</p>
						</div>
					</div>
				</div>
				
			</div>
			<hr>
			<%@include file="/adminjsps/foot.jsp"%>
			<script src="js/jquery.js"></script>
			<script src="js/bootstrap.min.js"></script>
	</c:if>
	<c:if test="${sessionScope.level!=1}">
	<h1 style="text-align: center">你没有权限访问此页面</h1>
	</c:if>
</body>
</html>
