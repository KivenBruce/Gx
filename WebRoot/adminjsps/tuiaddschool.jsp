<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>Cubic-新增推荐</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Admin panel developed with the Bootstrap from Twitter.">
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<script src="../adminjsps/My97DatePicker/WdatePicker.js"></script>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/site.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<style type="text/css">
.divv {
	font-size: 20px;
	margin: 0 20px 20px 0;
	vertical-align: middle;
}

.divv span {
	margin: 0 35px 15px 0;
}
</style>
<script language="javascript">
	function judge() {
		if ($.trim($("#gtheme").val()) == "") {
			document.getElementById("egtheme").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动主题！</span>";
			return false;
		} else {
			document.getElementById("egtheme").innerHTML = "";
		}

		if ($.trim($("#gpart").val()) == "") {
			document.getElementById("egpart").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动内容！</span>";
			return false;
		} else {
			document.getElementById("egpart").innerHTML = "";
		}

		if ($.trim($("#gtime").val()) == "") {
			document.getElementById("egtime").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写举办时间！</span>";
			return false;
		} else {
			document.getElementById("egtime").innerHTML = "";
		}

		if ($.trim($("#gplace").val()) == "") {
			document.getElementById("egplace").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动地点！</span>";
			return false;
		} else {
			document.getElementById("egplace").innerHTML = "";
		}

		if ($.trim($("#gusername").val()) == "") {
			document.getElementById("egusername").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写主持人！</span>";
			return false;
		} else {
			document.getElementById("egusername").innerHTML = "";
		}

		if ($.trim($("#gperson").val()) == "") {
			document.getElementById("egperson").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动人数！</span>";
			return false;
		} else {
			document.getElementById("egperson").innerHTML = "";
		}
		if ($.trim($("#gtupian").val()) == "") {
			document.getElementById("egtupian").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动图片！！</span>";
			return false;
		} else {
			document.getElementById("egtupian").innerHTML = "";
		}

		if ($.trim($("#gremain").val()) == "") {
			document.getElementById("egremain").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动类型！</span>";
			return false;
		} else {
			document.getElementById("egremain").innerHTML = "";
		}

		if ($.trim($("#gprice").val()) == "") {
			document.getElementById("egprice").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写门票价格！</span>";
			return false;
		} else {
			document.getElementById("egprice").innerHTML = "";
		}
		if ($.trim($("#gcontent").val()) == "") {
			document.getElementById("egcontent").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动详细！</span>";
			return false;
		} else {
			document.getElementById("egcontent").innerHTML = "";
		}
	}
</script>

</head>
<body>
	<c:if test="${sessionScope.level==1}">
		<%@include file="/adminjsps/head.jsp"%>
		<%
			String type = request.getParameter("type");
				String url = "/" + type + "Servlet?method=addTuiSchool";
				String cancel = "/" + type + "Servlet?method=findAll";
				if (type.contains("In")) {
		%>
		<c:set var="tt" value="0"></c:set>
		<%
			} else {
		%>
		<c:set var="tt" value="1"></c:set>
		<%
			}
		%>
		<div class="container-fluid">
			<div class="row-fluid">
				<%@include file="/adminjsps/left.jsp"%>
				<div class="span9">
					<div class="row-fluid">
						<div class="page-header">
							<c:if test="${tt=='0'}">
								<h1>
									校内推荐活动 <small>新增信息</small>
								</h1>
							</c:if>
							<c:if test="${tt=='1' }">
								<h1>
									校外推荐活动 <small>新增信息</small>
								</h1>
							</c:if>
						</div>
						<form onsubmit="return judge()" action="<c:url value='<%=url%>'/>"
							method="post">

							<div class="divv">
								<span> 活动主题: <input type="text" id="gtheme" name="gtheme"
									value="${school.gtheme }" />
								</span> <span id="egtheme"></span> <span> 举办单位: <input
									type="text" id="gpart" name="gpart" value="${school.gpart }" />
								</span> <span id="egpart"></span>
							</div>
							<div class="divv">
								<span> 举办时间 :<input type="text" id="gtime" name="gtime"
									value="${school.gtime }"
									onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm' })"
									autocomplete="off" />

								</span> <span id="egtime"></span> <span> 举办地点 :<input
									type="text" id="gplace" name="gplace" value="${school.gplace }" />
								</span> <span id="egplace"></span>
							</div>
							<div class="divv">
								<span> 举 &nbsp办 &nbsp者 :<input type="text" id="gusername"
									name="gusername" value="${school.gusername }" /> <span
									id="egusername"></span>
								</span> <span> 所需人数: <input type="text" id="gperson"
									name="gperson" value="${school.gperson }" /> <span
									id="egperson"></span>
								</span>
							</div>
							<div class="divv">
								<span> 图片:<input type="file" id="gtupian" name="gtupian"
									value="${school.gtupian}" />
								</span> <span id="egtupian"></span> <span style="margin-left: 35px">
									活动类型 :<input type="text" id="gremain" name="gremain"
									value="${school.gremain }" /> <span id="egremain"></span>
								</span>
							</div>
							<div class="divv">
								<span> 门票|每人 :<input type="text" id="gprice"
									name="gprice" value="${school.gprice }" /> <span id="egprice"></span>
								</span> <span>举办内容:<textarea id="gcontent" name="gcontent">								
									</textarea>
								</span> <span id="egcontent"></span> <input id="inpp" type="hidden"
									value="${school.gcontent }" />

							</div>
							<div class="form-actions">
								<input type="submit" class="btn btn-success btn-large"
									value="Save Changes" id="tj" /> <a class="btn"
									href="<%=path%><%=cancel%>">Cancel</a>
							</div>
						</form>
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
