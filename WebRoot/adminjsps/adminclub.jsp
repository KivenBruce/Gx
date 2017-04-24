<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cubic-Club详情</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="adminjsps/css/bootstrap.css" rel="stylesheet">
<link href="fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="adminjsps/css/site.css" rel="stylesheet">
<link href="adminjsps/css/bootstrap-responsive.css" rel="stylesheet">
<link href="adminjsps/css/button.css" rel="stylesheet">
<link href="adminjsps/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<script src="adminjsps/js/jquery.js"></script>
<script src="adminjsps/js/bootstrap.min.js"></script>
<script src="adminjsps/jquery-ui/jquery-ui.min.js"></script>
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
		var detail=contents.eq(4).text();
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
							<h1>Club详情</h1>
						</div>
						<div style="vertical-align: middle; margin-bottom: 20px;">
							<span
								style="width: 55px; font-size: 19px; vertical-align: middle">club名称:</span>
							<span> <input id="question" type="text" style="width: 120px" />
							</span><span><input type="image" src="adminjsps/img/5.jpg"
								style="width: 40px; height: 24px;" onclick="search()" /></span>
						</div>
						<table class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th>序号</th>
									<th>Club名称</th>					
									<th>Club类型</th>
									<th>Club描述</th>
									<th>Club管理员</th>
									<th>图片路径</th>
									<th>clubid</th>
									<th>校内/校外</th>
									<th>管理</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pb.beanList }" varStatus="vstatus"
									var="club">
									<tr class="list-users">
										<td>${vstatus.count}</td>
										<td>${club.club_name }</td>
										<td>${club.club_parent }</td>										
										<c:if test="${fn:length(club.club_desc) > 4}">
											<td onclick="showDetail(this)" style="cursor: pointer;">${fn:substring(club.club_desc,0,10)}...</td>
										</c:if>
										<c:if test="${fn:length(club.club_desc) <= 4}">
											<td onclick="showDetail(this)" style="cursor: pointer;">${club.club_desc }</td>
										</c:if>
										<td style="display: none">${club.club_desc }</td>
										<td>${club.club_hoster }</td>
										<td>${club.club_image }</td>
										<td>${club.club_id }</td>
										<c:if test="${club.gflag==0}">
											<td style="color:#79B7E4">校 内</td>
										</c:if>
										<c:if test="${club.gflag==1}">
											<td style="color:#EA3735">校 外</td>
										</c:if>										
										<td>
											<div class="btn-group">
												<a class="btn btn-mini dropdown-toggle"
													onmouseover="showul()">管理活动 <span class="caret"></span></a>
												<ul class="dropdown-menu">
													<li><a
														href="<c:url value='/ClubServlet?method=reload&gid=${club.club_id}'/>"><i
															class="icon-pencil"></i>修改</a></li>
													<li><a onclick="firm(${club.club_id})"
														style="cursor: pointer;"><i class="icon-trash"></i> 删除</a></li>
												</ul>
											</div>
										</td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div>
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
												href="/Gx/ClubServlet?method=findByAdmin&curPage=1&question=${question }">首页</a></span>
											<span class="datatable-paging-previous"></span>
											<span style="margin-right: 7px;"><a
												href="/Gx/ClubServlet?method=findByAdmin&curPage=${curPage-1}&question=${question }">上一页</a></span>
										</c:if> <span style="margin-left: 7px;"><a
											href="/Gx/ClubServlet?method=findByAdmin&curPage=${curPage+1}&question=${question }">下一页</a></span>
										<span class="datatable-paging-next"></span> <span><a
											href="/Gx/ClubServlet?method=findByAdmin&curPage=${pb.getPageCount()}&question=${question }">尾页</a></span><span
										class="datatable-paging-last"></span> <span
										style="margin-left: 7px;">跳转到：</span> <span
										style="text-align: center;"><input id="showPage"
											type="text" style="width: 30px; height: 20px;" /></span> <span><input
											type="image" src="adminjsps/img/go.gif"
											style="width: 30px; height: 20px; border-radius: 4px"
											onclick="jumpToPage()" /></span>
								</span></td>
							</tr>
						</div>
					</div>
				</div>
			</div>
			<hr>	
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
				"/Gx/ClubServlet?method=findByAdmin&curPage=" + jumppage+"&question=${question}");
	}
</script>
<script type="text/javascript">
	function firm(gid) {
				if (confirm("你确认要删除这条活动?")) {
					$('body').load('/Gx/ClubServlet?method=deleteClub&gid='+gid);
				}
			}
			function showul(){
				$("ul").show();
			}
				function search() {
					var question = $('#question').val();
					var url = "/Gx/ClubServlet?method=findByAdmin&question="+question;
					url = encodeURI(url);
					url = encodeURI(url);
					/*  $('body').load(url);  */
					window.location = url;
				}
</script>
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
