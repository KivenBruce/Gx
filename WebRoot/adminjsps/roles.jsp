<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/adminjsps/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<title>Roles | Strass</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Admin panel developed with the Bootstrap from Twitter.">
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/site.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link href="css/button.css" rel="stylesheet">
<style>
.newuser a:hover {
	color: #0088cc
}
</style>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.dropdown-menu li a').hover(function() {
			$(this).children('i').addClass('icon-white');
		}, function() {
			$(this).children('i').removeClass('icon-white');
		});
	});
	function firm(gid) {
		if (confirm("你确认要删除此用户?")) {
			$('body').load(
					'/Gx/UserServlet?method=deleteUser&gid='+gid);
		}
	}
	function reset(gid) {
		if (confirm("你确认要重置此用户的密码?")) {
			$('body').load(
					'/Gx/UserServlet?method=resetPass&gid='+gid);
		}
	}
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
		if (jumppage > '${pb.pageCount}') {
			alert("Error: 输入的页码超过总页数，请重新输入！");
			return;
		}
		$('body').load(
				"/Gx/UserServlet?method=findAll&curPage=" + jumppage
						+ "&username=${username}&userlevel=${userlevel}");
	}
	function search() {
		var username = $("#username").val();
		var userlevel = $('#userlevel').val();
		$('body').load(
				"/Gx/UserServlet?method=findAll&username=" + username
						+ "&userlevel=" + userlevel);
	}
	function showul2(e){
		$(e).parent().parent().parent().children("td").eq(6).children("div").children("ul").hide();
		$(e).parent().children("ul").show().delay(15000).hide(0);
	}
	function showul1(e){
		$(e).parent().parent().parent().children("td").eq(7).children("div").children("ul").hide();
		$(e).parent().children("ul").show().delay(15000).hide(0);
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
							<h1 class="newuser">
								用户管理 <small><a href="adduser.jsp">新建用户</a></small>
							</h1>
						</div>

						<div style="vertical-align: middle; margin-bottom: 15px;">
							<span
								style="width: 55px; font-size: 19px; vertical-align: middle">用户名</span>
							<input id="username" type="text" /> <span
								style="width: 55px; font-size: 19px; padding-left: 10px; vertical-align: middle">级别</span>
							<span> <select id="userlevel">
									<option value="0">--请选择--</option>
									<option value="1">管理员</option>
									<option value="2">高级会员</option>
									<option value="3">普通会员</option>
							</select>
							</span> <span><input type="image" src="<%=basePath%>img/5.jpg"
								style="width: 35px; height: 24px;" onclick="search()" /></span>
						</div>

						<table class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th>序号</th>
									<th>用户名</th>
									<th>邮箱</th>
									<th>手机号码</th>
									<th>创建时间</th>
									<th>级别</th>
									<th>权限管理</th>
									<th>用户管理</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pb.beanList }" varStatus="vstatus"
									var="user">
									<tr class="list-roles">
										<td>${vstatus.count}</td>
										<td>${user.gusername }</td>
										<td>${user.gmail }</td>
										<td>${user.gtel }</td>
										<td>${user.gcreateTime }</td>
										<td><c:choose>
												<c:when test="${user.level eq 1 }">管理员</c:when>
												<c:when test="${user.level eq 2 }">高级会员</c:when>
												<c:when test="${user.level eq 3 }">普通会员</c:when>
											</c:choose></td>
										<td>
											<div class="btn-group">
												<a class="btn btn-mini dropdown-toggle"
													onmouseover="showul1(this)">权限管理 <span class="caret"></span></a>
												<ul class="dropdown-menu pull-right" style="display: none">
													<c:choose>
														<c:when test="${user.level eq 2 }">
															<li><a
																href="<c:url value='/UserServlet?method=level&gusername=${user.gusername }&levelbofore=${user.level}&level=-1'/>"><i
																	class="icon-pencil"></i>升级</a></li>
														</c:when>
														<c:when test="${user.level eq 3 }">
															<li><a
																href="<c:url value='/UserServlet?method=level&gusername=${user.gusername }&levelbofore=${user.level}&level=-1'/>"><i
																	class="icon-pencil"></i>升级</a></li>
														</c:when>

													</c:choose>
													<c:choose>
														<c:when test="${user.level eq 1 }">
															<li><a
																href="<c:url value='/UserServlet?method=level&gusername=${user.gusername }&levelbofore=${user.level}&level=1'/>"><i
																	class="icon-trash"></i> 降级</a></li>
														</c:when>
														<c:when test="${user.level eq 2 }">
															<li><a
																href="<c:url value='/UserServlet?method=level&gusername=${user.gusername }&levelbofore=${user.level}&level=1'/>"><i
																	class="icon-trash"></i>降级</a></li>
														</c:when>

													</c:choose>
												</ul>
											</div>
										</td>
										<td>
											<div class="btn-group">
												<a class="btn btn-mini dropdown-toggle"
													onmouseover="showul2(this)">用户管理 <span class="caret"></span></a>
												<ul class="dropdown-menu">
													<li><a
														href="<c:url value='/UserServlet?method=reload&gid=${user.id}'/>"><i
															class="icon-pencil"></i>修改</a></li>
													<li><a onclick="firm(${user.id})"
														style="cursor: pointer;"><i class="icon-trash"></i> 删除</a></li>
													<li><a onclick="reset(${user.id})"
														style="cursor: pointer;"><i class="fa fa-pencil-square-o"></i>重置</a></li>
												</ul>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<tfoot>
							<tr>
								<td class="datatable-paging-info" colspan="5"><span
									class="datatable-paging-count"> 第 <span>${curPage}</span>
										页/共 <span>${pb.pageCount}</span> 页
								</span> <span class="datatable-paging-total"> 总共 <span>${pb.tr}</span>
										条数据
								</span></td>

								<td><span style="float: right"> <c:if
											test="${curPage>1}">
											<span class="datatable-paging-first"></span>
											<span><a
												href="/Gx/UserServlet?method=findAll&curPage=1&username=${username}&userlevel=${userlevel}">首页</a></span>
											<span class="datatable-paging-previous"></span>
											<span style="margin-right: 7px;"><a
												href="/Gx/UserServlet?method=findAll&curPage=${curPage-1}&username=${username}&userlevel=${userlevel}">上一页</a></span>
										</c:if> <span style="margin-left: 7px;"><a
											href="/Gx/UserServlet?method=findAll&curPage=${curPage+1}&username=${username}&userlevel=${userlevel}">下一页</a></span>
										<span class="datatable-paging-next"></span> <span><a
											href="/Gx/UserServlet?method=findAll&curPage=${pb.getPageCount()}&username=${username}&userlevel=${userlevel}">尾页</a></span><span
										class="datatable-paging-last"></span> <span
										style="margin-left: 7px;">跳转到：</span> <span
										style="text-align: center;"><input id="showPage"
											type="text" style="width: 30px; height: 20px;" /></span> <span><input
											type="image" src="<%=basePath%>img/go.gif"
											style="width: 30px; height: 20px; border-radius: 4px"
											onclick="jumpToPage()" /></span>
								</span></td>
							</tr>
						</tfoot>
					</div>
				</div>
			</div>
			<hr>
			<%@include file="/adminjsps/foot.jsp"%>
		</div>
	</c:if>
	<c:if test="${sessionScope.level!=1}">
		<h1 style="text-align: center">你没有权限访问此页面</h1>
	</c:if>
</body>
</html>
