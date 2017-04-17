<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="span3">
	<div class="well sidebar-nav" style="margin-top:0px">
		<ul class="nav nav-list">
			<li class="nav-header"><i class="icon-user"></i> 高级选项</li>
			<li><a
				href="<c:url value='/UserServlet?method=findAll'/>">用户管理</a></li>

			<li class="nav-header"><i class="fa fa-group"></i> 校外活动</li>
			<li><a href="<c:url value='/SchoolServlet?method=findAll&type=1'/>">管理活动</a></li>
			<li><a href="addschool.jsp?type=1">添加活动</a></li>

			<li class="nav-header"><i class="fa fa-graduation-cap"></i> 校内活动</li>
			<li><a href="<c:url value='/SchoolServlet?method=findAll&type=0'/>">管理活动</a></li>
			<li><a href="addschool.jsp?type=0">添加活动</a></li>

			<li class="nav-header"><i class="icon-bell"></i> 热门推荐</li>
			<li><a href="<c:url value='/SchoolServlet?method=findAll&type=2'/>">校内推荐</a></li>
			<li><a href="<c:url value='/SchoolServlet?method=findAll&type=3'/>">校外推荐</a></li>

			<!-- <li><a href="user-stats.jsp">首页管理(index)</a></li> -->
			<li class="nav-header"><i class="fa fa-map-marker"></i> 网站导航</li>
			<li><a href="<c:url value='/NavServlet?method=findAll&type=inlist'/>">校内导航</a></li>
			<li><a href="<c:url value='/NavServlet?method=findAll&type=outlist'/>">校外导航</a></li>
			<%-- <li class="nav-header"><i class="fa fa-paper-plane"></i> 外观管理</li>
			<li><a href="<c:url value='/OutServlet?method=findAll'/>">首页</a></li>
			<li><a href="<c:url value='/ThemeServlet?method=findAll'/>">主题</a></li> --%>
		</ul>
	</div>
</div>