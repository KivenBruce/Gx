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
<title>Cubic-所有活动</title>
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
								活动 <small>${msg }</small>
							</h1>
						</div>
						<div style="vertical-align: middle; margin-bottom: 20px;">
							<span
								style="width: 55px; font-size: 19px; vertical-align: middle">活动日期</span>
							<span> <input type="text" id="datefrom"
								style="width: 120px"
								onfocus="WdatePicker({dateFmt:'yyyy-M-d',maxDate:'%y-%M-{%d+5} 23:59:59'})" />
								<span style="padding-top: 2px">--</span> <input type="text"
								id="dateto" style="width: 120px"
								onfocus="WdatePicker({dateFmt:'yyyy-M-d',minDate:'#F{$dp.$D(\'datefrom\')}',maxDate:'%y-%M-{%d+5} 23:59:59'})" />
							</span> <span
								style="width: 55px; font-size: 19px; padding-left: 10px; vertical-align: middle">活动地点</span>
							<span> <input id="place" type="text" style="width: 120px" />
							</span> <span><input type="image" src="<%=basePath%>img/5.jpg"
								style="width: 40px; height: 24px;" onclick="search()" /></span>
						</div>
						<c:if test="${fn:length(type)>8 }">
							<c:set var="gotos" value='/OutschoolServlet?' />
						</c:if>
						<c:if test="${fn:length(type)<9 }">
							<c:set var="gotos" value='/InschoolServlet?' />
						</c:if>
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
									<th>管理</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pb.beanList }" varStatus="vstatus"
									var="school">
									<tr class="list-users">
										<td>${vstatus.count}</td>
										<td>${school.gtheme }</td>
										<td>${school.gpart }</td>
										<td>${school.gtime }</td>
										<c:if test="${fn:length(school.gcontent) > 4}">
											<td onclick="showDetail(this)" style="cursor: pointer;">${fn:substring(school.gcontent,0,4)}...</td>
										</c:if>
										<c:if test="${fn:length(school.gcontent) <= 4}">
											<td onclick="showDetail(this)" style="cursor: pointer;">${school.gcontent }</td>
										</c:if>
										<td style="display: none">${school.gcontent }</td>
										<td>${school.gusername }</td>
										<td>${school.gperson }</td>
										<th>${school.gremain }</th>
										<td>${school.gprice }</td>
										<td>${school.gplace }</td>
										<td>${school.gtupian }</td>
										<td>
											<div class="btn-group">
												<a class="btn btn-mini dropdown-toggle"
													onmouseover="showul()">管理活动 <span class="caret"></span></a>
												<ul class="dropdown-menu">
													<li><a
														href="<c:url value='${ gotos}method=reload&gid=${school.id}'/>"><i
															class="icon-pencil"></i>修改</a></li>
													<li><a onclick="firm(${school.id})"
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
												href="/Gx${ gotos}method=findAll&curPage=1&datefrom=${datefrom}&dateto=${dateto}&place=${place}">首页</a></span>
											<span class="datatable-paging-previous"></span>
											<span style="margin-right: 7px;"><a
												href="/Gx${ gotos}method=findAll&curPage=${curPage-1}&datefrom=${datefrom}&dateto=${dateto}&place=${place}">上一页</a></span>
										</c:if> <span style="margin-left: 7px;"><a
											href="/Gx${ gotos}method=findAll&curPage=${curPage+1}&datefrom=${datefrom}&dateto=${dateto}&place=${place}">下一页</a></span>
										<span class="datatable-paging-next"></span> <span><a
											href="/Gx${ gotos}method=findAll&curPage=${pb.getPageCount()}&datefrom=${datefrom}&dateto=${dateto}&place=${place}">尾页</a></span><span
										class="datatable-paging-last"></span> <span
										style="margin-left: 7px;">跳转到：</span> <span
										style="text-align: center;"><input id="showPage"
											type="text" style="width: 30px; height: 20px;" /></span> <span><input
											type="image" src="<%=basePath%>img/go.gif"
											style="width: 30px; height: 20px; border-radius: 4px"
											onclick="jumpToPage()" /></span>
								</span></td>
							</tr>
						</div>
					</div>
				</div>
			</div>

			<hr>
			<%@include file="/adminjsps/foot.jsp"%>
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
				"/Gx" + '${gotos}' + "method=findAll&curPage=" + jumppage+"&datefrom=${datefrom}&dateto=${dateto}&place=${place}");
	}

			
			
			</script>
			<script type="text/javascript">
			function firm(gid) {
				if (confirm("你确认要删除这条活动?")) {
					$('body').load(
							'/Gx' + '${gotos}'
									+ 'method=delete&gid='+gid);
				}
			}
			function showul(){
				$("ul").show();
			}
				function search() {
					var datefrom = $("#datefrom").val();
					var dateto = $('#dateto').val();
					var place = $('#place').val();
					var url = "/Gx" + '${gotos}' + "method=findAll&datefrom="
							+ datefrom + "&dateto=" + dateto + "&place="
							+ place;
					url = encodeURI(url);
					url = encodeURI(url);
					/*  $('body').load(url);  */
					window.location = url;
				}
			</script>
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
