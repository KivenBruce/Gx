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
<meta charset="utf-8">
<title>Cubic-导航编辑</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Admin panel developed with the Bootstrap from Twitter.">
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<script src="../adminjsps/My97DatePicker/WdatePicker.js"></script>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/site.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script src="js/judge.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		document.getElementById('gcontent').value = document
				.getElementById('inpp').value;
	});

	function gd() {
		var value = document.getElementById("radio").checked;
		if (!value) {//选否
			$("#gurl").val("0");
			document.getElementById("gurl").disabled = true;
		} else {
			document.getElementById("gurl").disabled = false;
		}
	}
</script>
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
</head>
<body>
	<%@include file="/adminjsps/head.jsp"%>

	<div class="container-fluid">
		<div class="row-fluid">
			<%@include file="/adminjsps/left.jsp"%>
			<div class="span9">
				<div class="row-fluid">
					<div class="page-header">
						<h1>
							<c:if test="${type=='inlist' }">校内导航活动</c:if>
							<c:if test="${type=='outlist' }">校外导航活动</c:if>
							<small>更新信息</small>
						</h1>
					</div>
					<form onsubmit="return judge()" 
						action="<c:url value='/NavServlet?method=editNav&gid=${gid}&type=${type}'/>"
						method="post">

						<fieldset>
							<div class="divv">
								<span> 活动主题: <input type="text" id="gtheme" name="gtheme"
									value="${nav.gtheme }" />
								</span><span id="egtheme"></span> <span> 举办单位: <input
									type="text" id="gpart" name="gpart" value="${nav.gpart }" />
								</span><span id="egpart"></span>
							</div>
							<div class="divv">
								<span> 举办时间 :<input type="text" id="gtime" name="gtime"
									value="${nav.gtime }"
									onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm' })"
									autocomplete="off" />

								</span><span id="egtime"></span> <span> 举办地点 :<input type="text"
									id="gplace" name="gplace" value="${nav.gplace }" />

								</span><span id="egplace"></span>
							</div>
							<div class="divv">
								<span> 举 &nbsp办 &nbsp者 :<input type="text" id="gusername"
									name="gusername" value="${nav.gusername }" />

								</span><span id="egusername"></span> <span> 所需人数: <input
									type="text" id="gperson" name="gperson" value="${nav.gperson }" />

								</span><span id="egperson"></span>
							</div>
							<div class="divv">
								<span> 图片:<input type="file" id="tupian" name="tupian" />
									<input id="gtupian" name="gtupian" type="hidden"
									value="${nav.gtupian }" />
								</span><span id="egtupian"></span> <span style="margin-left: 35px">
									活动类型 :<input type="text" id="gremain" name="gremain"
									value="${nav.gremain }" />

								</span><span id="egremain"></span>
							</div>
							<div class="divv">
								<span> 门票|每人 :<input type="text" id="gprice"
									name="gprice" value="${nav.gprice }" />

								</span><span id="egprice"></span> <span>活动内容:<textarea
										id="gcontent" name="gcontent"></textarea></span> <span id="egcontent"></span>
								 <input id="inpp" type="hidden" value="${nav.gcontent }" />
							</div>
							<div class="divv">
								<span> 是否为广告 : </span> <span><input id="radio" type=radio
									name=aa value="1" onclick="gd()" checked>是</span> <span><input
									id="radio" type=radio name=aa value="0" onclick="gd()">否</span>
								<span style="margin-left: 50px">广告链接:<input type="text" value="http://"
									id="gurl" name="gurl" />
								</span><span id="egurl"></span> 
							</div>
							<div class="form-actions">
								<input type="submit" class="btn btn-success btn-large"
									value="Save Changes" /> <a class="btn"
									href="<%=path%>/NavServlet?method=findAll&type=${type}">Cancel</a>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
		<hr>
		<%@include file="/adminjsps/foot.jsp"%>

	</div>
</body>
</html>
