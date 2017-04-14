<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.DateFormat"%>
<link href="../fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<style>
.container-fluid {
	height: 70px;
}

.link {
	color: white;
	font-size: 15px;
	cursor: pointer;
}

.top-menu a:hover {
	color: yellow;
	text-decoration: none;
}

.user {
	line-height: 70px;
	text-align: center;
	cursor: default;
	color: white;
	position: absolute;
	left: 45%;
	font-size: 15px;
}
</style>
<%
	Date date = new Date();
	String s = DateFormat.getDateInstance(DateFormat.FULL).format(date);
%>
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container-fluid">
			<a class="btn btn-navbar" data-toggle="collapse"
				data-target=".nav-collapse"> <span class="icon-bar"></span> <span
				class="icon-bar"></span> <span class="icon-bar"></span>
			</a>
			<h1 class="brand"
				style="margin: 0; padding: 18px; font-size: 30px; cursor: default; font-family: 微软雅黑, 黑体, 宋体; color: white;">
				BISTU后台管理系统</h1>
			<div class="user">
				你好, <span class="online-total"><%=session.getAttribute("name")%></span>&nbsp&nbsp&nbsp&nbsp
				<span><%=s%></span>
			</div>
			<div class="top-menu"
				style="position: absolute; top: 25px; right: 10px; color: white; font-size: 15px;">
				<a class="link" href="index1.jsp"> <i class="fa fa-home"></i> 首页
				</a> | <a class="link" href="stats.jsp"> <i class="fa fa-book"></i> 帮助
				</a> | <a class="link"href="reset.jsp"> <i class="fa fa-gear"></i> 修改密码
				</a> | <a class="link" href="../Logout.do"> <i
					class="fa fa-sign-out"></i> 注销
				</a>
			</div>
		</div>
	</div>
</div>