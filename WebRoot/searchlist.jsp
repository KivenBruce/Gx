<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Cubic - One Page Responsive HTML 5 Website Template</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />

<link rel="stylesheet" href="css/bootstrap.css" type="text/css">
<link rel="stylesheet" href="css/jpreloader.css" type="text/css">
<link rel="stylesheet" href="css/animate.css" type="text/css">
<link rel="stylesheet" href="css/owl.carousel.css" type="text/css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<!-- color scheme -->
<link rel="stylesheet" href="css/color.css" type="text/css">
<!-- custom style css -->
<link rel="stylesheet" href="css/custom-style.css" type="text/css">
<link rel="stylesheet" href="fonts/font-awesome/css/font-awesome.css"
	type="text/css">
<link rel="stylesheet" href="css/count.css" type="text/css">
<!-- 自定义css,count样式 -->
<!-- Javascript Files-->
<script src="js/jquery.min.js"></script>
<script src="js/jpreLoader.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<!-- <script src="js/jquery.ui.totop.js"></script> -->
<script src="js/owl.carousel.js"></script>
<script src="js/classie.js"></script>
<script src="js/designesia.js"></script>
<script src="js/search.js"></script>
<!-- 自定义js -->
<style>
#mainmenu  a {
	color: #333;
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
		if (jumppage > '${pb.pageCount}') {
			alert("Error: 输入的页码超过总页数，请重新输入！");
			return;
		}
		$('body').load(
				"/Gx/FrontServlet?method=searchAll&curPage=" + jumppage
						+ "&q=${question}" + "&gflag=${gflag}");
	}

	function mOver(obj) {
		obj.style.backgroundColor = "#ffffff";
	}

	function mOut(obj) {
		obj.style.backgroundColor = "#f7f7f7";
	}

	$(document).keydown(function(event) {
		if (event.keyCode == 13) { //绑定回车
			$('#searchimg').click();
		}
	});
	function selectIn() {//gflag=0则为校内活动,只查询校内	
		var getqu = $("#getqu").val();
		var url = "/Gx" + '/FrontServlet?' + "method=searchAll&q=" + getqu
				+ "&gflag=0";
		url = encodeURI(url);
		window.location = url;
	}
	function selectOut() {
		var getqu = $("#getqu").val();
		var url = "/Gx" + '/FrontServlet?' + "method=searchAll&q=" + getqu
				+ "&gflag=1";
		url = encodeURI(url);
		window.location = url;
	}
	function selectAll() {
		var getqu = $("#getqu").val();
		var url = "/Gx" + '/FrontServlet?' + "method=searchAll&q=" + getqu;
		url = encodeURI(url);
		window.location = url;
	}

	function changeNum(e){
		var num=$("#"+e).text();
		var newnum=Number(num)+1;
		$("#"+e).text(newnum);
	}
</script>
</head>
<body id="homepage" style="background-color: #f7f7f7;">
	<div id="wrapper">
		<input id="getqu" type="text" style="display: none" value=${question}>
		<div class="page-overlay"></div>
		<header>
			<div class="container">
				<div class="row">

					<div class="col-md-12">
						<h1 id="logo">
							<a href="index.jsp"> <img class="logo-1"
								src="images/logo.png" alt=""> <img class="logo-2"
								src="images/logo-2.png" alt="">
							</a>
						</h1>
						<span id="menu-btn"></span> <span id="newinput"><input
							id="q" name="q" autocomplete="off" value="" maxlength="280px"
							placeholder="搜索你感兴趣的内容..." type="text" /></span> <span><input
							id="searchimg" type="image" src="/Gx/adminjsps/img/search1.png"
							style="width: 40px; vertical-align: middle; margin-left: -4px; border-radius: 4px"
							onclick="search()" /></span>


						<ul id="mainmenu">
							<li><a class="active" href="Main.do">首页</a></li>
							<li><a
								href="<c:url value='/FrontServlet?method=findAll&type=in'/>">校内活动</a></li>
							<li><a
								href="<c:url value='/FrontServlet?method=findAll&type=out'/>">校外活动</a></li>
							<li><a href="/Gx/ClubServlet?method=findAll">兴趣社区</a></li>
						</ul>
					</div>
					<div id="count">
						<img src="/Gx/adminjsps/img/account.png" height="33" width="33">
					</div>
					<div id="countinfo">
						<ul id="myul" class="">
							<li><a
								href="<c:url value='/UserServlet?method=reloadAccount'/>"
								style="text-decoration: none"> <i style="margin-top: 5px"
									class="fa  fa-rebel"></i> 我的主页
							</a></li>
							<li><a href="Logout.do" style="text-decoration: none"> <i
									style="margin-top: 5px" class="fa  fa-power-off"></i> 注 销
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</header>
	</div>

	<div
		style="background-image: url(images/background/body.png); padding: 150px 90px 140px;">
		<c:if test="${pb.getPageCount()!=0 and pb.getPageCount()!=''}">
			<div id="main" style="height: 40px; margin-bottom: 20px;">
				<div id="left" onclick="selectIn()"
					style="float: left; width: 33%; height: 100%; text-align: center; background-color: #e0ffff; border-radius: 8px; line-height: 40px; font-size: 30px; cursor: pointer;">只看校内</div>
				<div id="left" onclick="selectAll()"
					style="float: left; width: 34%; height: 100%; text-align: center; background-color: #fafad2; border-radius: 8px; line-height: 40px; font-size: 30px; cursor: pointer;">查看全部</div>
				<div id="right" onclick="selectOut()"
					style="float: left; width: 33%; height: 100%; text-align: center; background-color: #e0ffff; border-radius: 8px; line-height: 40px; font-size: 30px; cursor: pointer;">只看校外</div>

			</div>
		</c:if>

		<c:choose>
			<c:when test="${pb.getPageCount()!=0 and pb.getPageCount()!=''}">
				<c:forEach var="item" items="${ pb.beanList}">
					<div>
						<div
							style="background-color: #ffffff; border: 1px solid gray; border-top-width: 0px; padding: 10px 20px;">

							<div style="float: left; width: 600px; padding: 10px 0px;">
								<table style="margin-left: 0px; padding-left: 0px;">
									<tr>
										<td rowspan="4"><img alt="图标"
											src="FrontServlet?method=doImage&filepath=${item.gtupian}"
											style="width: 80px; height: 80px; padding: 0px 10px;" /></td>
										<td><span style="font-size: 16px;"> <a onclick="changeNum('${item.id}')"
												href="FrontServlet?method=actDetail&gid=${item.id}"
												target="_blank"> ${ item.gtheme} </a>
										</span></td>
									</tr>
									<tr>
										<td><span style="font-size: 14px; color: gray;">时间：${ item.gtime }</span>
										</td>
									</tr>
									<tr>
										<td><span style="font-size: 14px; color: gray;">地点：${ item.gplace }</span>
										</td>
									</tr>
									<tr>
										<td><span style="font-size: 14px; color: gray;">类型：${ item.gremain }</span>
										</td>
									</tr>
								</table>
							</div>
							<div
								style="line-height: 35px; float: right; padding: 0px 10px; margin-top: 20px;">

								<table>
									<tr>
										<c:if test="${ item.gflag==0||item.gflag==2 }">
											<td><a style="color: #FFA500"
												href="<c:url value='/FrontServlet?method=findAll&type=in'/>">校内活动</a></td>
										</c:if>
										<c:if test="${ item.gflag==1||item.gflag==3 }">
											<td><a style="color: #9400D3"
												href="<c:url value='/FrontServlet?method=findAll&type=out'/>">校外活动</a></td>
										</c:if>
									</tr>
									<tr>
										<td>已浏览: <span  id="${item.id}">${item.gvisits}</span></td>
									</tr>
								</table>
							</div>
							<c:remove var="key" />
							<div style="clear: both;"></div>
						</div>
						<br>

					</div>
				</c:forEach>
			</c:when>

			<c:otherwise>
				<div style="text-align: center; line-height: 6; height: 120px">
					<h1>还没有任何相关活动~~~~</h1>
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
		<c:if test="${pb.getPageCount()!=0 and pb.getPageCount()!=''}">
			<div style="margin-top: 5px">
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
									href="/Gx/FrontServlet?method=searchAll&q=${question }&gflag=${gflag}">首页</a></span>
								<span class="datatable-paging-previous"></span>
								<span style="margin-right: 7px;"><a
									href="/Gx/FrontServlet?method=searchAll&curPage=${curPage-1}&q=${question}&gflag=${gflag}">上一页</a></span>
							</c:if> <span style="margin-left: 7px;"><a
								href="/Gx/FrontServlet?method=searchAll&curPage=${curPage+1}&q=${question}&gflag=${gflag}">下一页</a></span>
							<span class="datatable-paging-next"></span> <span><a
								href="/Gx/FrontServlet?method=searchAll&curPage=${pb.getPageCount()}&q=${question}&gflag=${gflag}">尾页</a></span><span
							class="datatable-paging-last"></span> <span
							style="margin-left: 7px;">跳转到：</span> <span
							style="text-align: center;"><input id="showPage"
								type="text" style="width: 30px; height: 20px;" /></span> <span><input
								type="image" src="<%=basePath%>/adminjsps/img/go.gif"
								style="width: 30px; height: 20px; border-radius: 4px; vertical-align: middle;"
								onclick="jumpToPage()" /></span>
					</span></td>
				</tr>
			</div>
		</c:if>
	</div>
	<%@include file="/adminjsps/foot.jsp"%>
</body>
</html>
