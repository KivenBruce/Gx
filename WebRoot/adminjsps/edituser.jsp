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
<script src="../js/validation-user.js"></script><!-- 自定义js,判断是否合法输入 -->
<style type="text/css">
.error {
	border: none;
	display: none;
	color: #C03;
	font-size: 12px;
}
</style>

<script language="javascript">
	$(function() {
		if ($("#msg").val() == "isexist") {
			document.getElementById("egname").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **该用户名已存在！</span>";
		}
	});
	function judge() {
		var q = document.getElementById("gusername").value;
		if (q == "") {
			document.getElementById("egname").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写用户名！</span>";
			return false;

		} else {
			document.getElementById("egname").innerHTML = "";
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
								修改用户 <small>User Edit</small>
							</h1>
						</div>
						<form onsubmit="return judge()"
							action="<c:url value='/UserServlet?method=editUser&gid=${gid}'/>"
							method="post">
							<fieldset>
								<input id="msg" type="hidden" value="${msg}" />
								<div class="control-group">
									<label class="control-label">用户名</label>
									<div class="controls">
										<input type="text" class="input-xlarge" id="gusername"
											maxlength="10" name="gusername" value="${user.gusername }" /><span
											id="egname"></span>

									</div>
								</div>
								<div class="control-group">
									<label class="control-label">邮 箱</label>
									<div class="controls">
										<input type="text" class="input-xlarge" id="gmail"
											name="gmail" value="${user.gmail }" /><span id="egemail"></span>
										<span id='email_error' class='error'>邮箱格式不正确!</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">手机号码</label>
									<div class="controls">
										<input type="text" class="input-xlarge" id="gtel" name="gtel"
											value="${user.gtel }" /><span id="egphone"></span> <span
											id='tel_error' class='error'>电话号码格式不正确!</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">级 别</label>
									<div class="controls">
										<select id="level" name="level">
											<option value="1">管理员</option>
											<option value="2">高级会员</option>
											<option value="3" selected>普通会员</option>
										</select>
									</div>
								</div>
								<div class="form-actions">
									<input type="submit" class="btn btn-success btn-large"
										id="send_message" value="Save User" /> <a class="btn"
										href="http://localhost:8080/Gx/UserServlet?method=findAll">Cancel</a>
								</div>
							</fieldset>
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
