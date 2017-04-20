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
<title>New User | Strass</title>
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
<script src="../js/validation-user.js"></script>
<script language="javascript">
function judge() {
	var q = document.getElementById("gid").value;
	if (q == "") {
		document.getElementById("egid").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写原密码！</span>";
		$("#egid").show().delay(3000).hide(0);
		return false;

	} else if (q !=<%=session.getAttribute("pwd")%>) {
		document.getElementById("egid").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **密码错误，请重新输入！</span>";
		$("#egid").show().delay(3000).hide(0);
		return false;
	} else {
		document.getElementById("egid").innerHTML = "";
	}
	var w = document.getElementById("gpwd").value;
	if (w == "") {
		document.getElementById("egnewid").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写新密码！</span>";
		$("#egnewid").show().delay(3000).hide(0);
		return false;
	} else if (w.length > 20 || w.length < 6) {
		document.getElementById("egnewid").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **密码长度错误，请重新输入！</span>";
		$("#egnewid").show().delay(3000).hide(0);
		return false;
	} else {
		document.getElementById("egnewid").innerHTML = "";
	}

	var e = document.getElementById("gnewids").value;
	if (e == "") {
		document.getElementById("egnewids").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请确认新密码！</span>";
		$("#egnewids").show().delay(3000).hide(0);
		return false;
	} else if (e != w) {
		document.getElementById("egnewids").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **两次密码不一样，请重新输入！</span>";
		$("#egnewids").show().delay(3000).hide(0);
		return false;
	} else {
		document.getElementById("egnewids").innerHTML = "";
	}
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
								修改密码 <small>RESET</small>
							</h1>
						</div>
						<form onsubmit="return judge()"
							action="<c:url value='/UserServlet?method=resetPass'/>"
							method="post">
							<fieldset>
								<div class="control-group">
									<span class="control-label">原 密 码 </span> &nbsp<input
										type="password" class="input-xlarge" id="gid" name="gid"
										value="" /><span id="egid"></span>
								</div>								<div class="control-group">
									<input type="hidden" class="input-xlarge" id="gusername"
									name="gusername" value=<%=session.getAttribute("name")%>>
								<div class="control-group">
									<span class="control-label">新 密 码 </span> &nbsp<input
										type="password" class="input-xlarge" id="gpwd" name="gpwd"
										placeholder="输入6~20位新密码,区分大小写" /> <span id="egnewid"></span>
								</div>
								<div class="control-group">
									<span class="control-label">确认密码</span> <input type="password"
										class="input-xlarge" id="gnewids" name="gnewids" /><span
										id="egnewids"></span>
								</div>
								<div class="form-actions">
									<input type="submit" class="btn btn-success btn-large"
										value="Save Changes" /> <a class="btn"
										href="index1.jsp">Cancel</a>
								</div>							
							</fieldset>
						</form>
					</div>
				</div>
			</div>

			<hr>

			<div style="bottom: 0; position: fixed; width: 97%">
			<%@include file="/adminjsps/foot.jsp"%>
		</div>

		</div>
	</c:if>
	<c:if test="${sessionScope.level!=1}">
		<h1 style="text-align: center">你没有权限访问此页面</h1>
	</c:if>
</body>
</html>
