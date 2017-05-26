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
<title>Cubic - Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Admin panel developed with the Bootstrap from Twitter.">
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/site.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	function setIframeSrc() {
		var iframe1 = document.getElementById('wea');
			if (window.confirm("天气加载超时，是否停止加载？")) {
				$("#wea").hide();
				$("#unit").show();
				window.stop();
			} else {
				document.execCommand('Stop'); // MSIE					
			}
	}
	setTimeout(setIframeSrc, 5000);
	
	/* setTimeout(setIframeSrc, 3000); */
</script>
</head>
<body>
	<c:if test="${sessionScope.level==1}">
		<%@include file="/adminjsps/head.jsp"%>
		<div class="container-fluid">
			<div class="row-fluid">
				<%@include file="/adminjsps/left.jsp"%>

				<div class="span9">
					<iframe id="wea" width=1140 height=500 frameborder=0 scrolling=NO
						style="zoom: 70%; margin-top: -50px;"
						src=http://m.weather.com.cn/m/pn6/weather.html></iframe>
					<div class="wells hero-unit" style="display: none" id="unit">
						<h1>
							Welcome,<%=session.getAttribute("name")%></h1>
						<p>本平台的设计是面向高校大学生校园内交友，学习、生活经验的交流而设计的信息交流平台，更快捷，更安全、更简单。</p>
						<p>
							<a class="btn btn-success btn-large" href="adduser.jsp">添加用户
								&raquo;</a>
						</p>

					</div>
					<div>
						<div style="float: left">
							<span style="font-size: 20px; font-weight: bold">访客总量</span> <a
								href="stats.jsp" class="badge badge-inverse"
								style="margin-left: 12px"><%=session.getAttribute("allv")%></a>

						</div>
						<div style="float: left; margin-left: 100px">
							<span style="font-size: 20px; font-weight: bold;">今日访客</span> <a
								href="stats.jsp" class="badge badge-inverse"
								style="margin-left: 12px"><%=session.getAttribute("todayv")%></a>
						</div>
					</div>
				</div>

			</div>
		</div>
		<hr>
		<div style="bottom: 0; position: fixed; width: 100%">
			<%@include file="/adminjsps/foot.jsp"%>
		</div>

	</c:if>
	<c:if test="${sessionScope.level!=1}">
		<h1 style="text-align: center">你没有权限访问此页面</h1>
	</c:if>
</body>
</html>
