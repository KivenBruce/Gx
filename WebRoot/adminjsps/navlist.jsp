<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>Cubic-导航活动</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description"
	content="Admin panel developed with the Bootstrap from Twitter.">
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/site.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/button.css" rel="stylesheet">
<link href="jquery-ui/jquery-ui.min.css" rel="stylesheet">
<script src="../adminjsps/My97DatePicker/WdatePicker.js"></script>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="jquery-ui/jquery-ui.min.js"></script>
<script type="application/javascript">
														
$(document).ready(function() {
	$('.dropdown-menu li a').hover(function() {
		$(this).children('i').addClass('icon-white');
	}, function() {
		$(this).children('i').removeClass('icon-white');
	});

	if ($(window).width() > 760) {
		$('tr.list-users td div ul').addClass('pull-right');
	}
});
function showul(e){
	$(e).parent().children("ul").show().delay(3000).hide(0);
}

</script>
<script>
	$(function() {
		$("#dialog").dialog({
			autoOpen : false,
			show : {
				effect : "blind",
				duration : 300
			}
		});				
	});
	function showDetail(e){
		var contents=$(e).parent().children("td");
		var detail=contents.eq(5).text();
		$("#contents").text(detail);
		$("#dialog").dialog("open"); 
		
	}
</script>
</head>
<body>
	<c:if test="${sessionScope.level==1}">
		<%@include file="/adminjsps/head.jsp"%>
		<div class="container-fluid">
			<div class="row-fluid">
				<%@include file="/adminjsps/left.jsp"%>
				<div class="span9">
					<div class="row-fluid">
						<div class="page-header">
							<h1>
								导航活动
								<c:if test="${type=='0'}">
									<small>校内导航</small>
								</c:if>
								<c:if test="${type=='1'}">
									<small>校外导航</small>
								</c:if>
							</h1>
						</div>
						<table class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th>序号</th>
									<th>活动主题</th>
									<th>举办单位</th>
									<th>活动时间</th>
									<th>活动内容</th>
									<th>举办人</th>
									<th>活动人数</th>
									<th>活动类型</th>
									<th>门票价格</th>
									<th>活动地点</th>
									<th>图片路径</th>
									<th>是否广告</th>
									<th>链接地址</th>
									<th>管理</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${navlist.beanList }" varStatus="vstatus"
									var="nav">
									<tr class="list-users">
										<td>${vstatus.count}</td>
										<td>${nav.gtheme }</td>
										<td>${nav.gpart }</td>
										<td>${nav.gtime }</td>
										<c:if test="${fn:length(nav.gcontent) > 4}">
											<td onclick="showDetail(this)" style="cursor: pointer;">${fn:substring(nav.gcontent,0,4)}…</td>
										</c:if>
										<c:if test="${fn:length(nav.gcontent) <= 4}">
											<td onclick="showDetail(this)" style="cursor: pointer;">${nav.gcontent }</td>
										</c:if>
										<td style="display: none">${nav.gcontent }</td>
										<td>${nav.gusername }</td>
										<td>${nav.gperson }</td>
										<th>${nav.gremain }</th>
										<td>${nav.gprice }</td>
										<td>${nav.gplace }</td>
										<td>${nav.gtupian }</td>
										<td>${nav.gadv }</td>
										<td>${nav.gurl }</td>
										<td>
											<div class="btn-group">
												<a class="btn btn-mini dropdown-toggle"
													onmouseover="showul(this)">管理活动 <span class="caret"></span></a>
												<ul class="dropdown-menu">
													<li><a
														href="<c:url value='/NavServlet?method=reload&gid=${nav.id}&type=${type}'/>"><i
															class="icon-pencil"></i>修改</a></li>
												</ul>
											</div>
										</td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<hr>
			
		</div>
		<div style="bottom: 0; position: fixed; width: 100%">
			<%@include file="/adminjsps/foot.jsp"%>
		</div>
	</c:if>
	<c:if test="${sessionScope.level!=1}">
		<h1 style="text-align: center">你没有权限访问此页面</h1>
	</c:if>
	
	<div id="dialog" title="活动内容细节">
		<p id="contents"></p>
	</div>

</body>
</html>
