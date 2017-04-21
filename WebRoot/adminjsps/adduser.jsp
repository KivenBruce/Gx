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
<title>Cubic-新增用户</title>
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
<style type="text/css">
.error {
	padding-left: 22px;
	color: #FF0033;
	display: none;
}
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
	$(function() {
		if ($("#msg").val() == "isexist") {
			document.getElementById("egname").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **该用户已存在！</span>";
		}
	});
	function judge(){
		if ($.trim($("#gimage").val()) == "") {
			document.getElementById("img_error").innerHTML = "**请填写活动图片！";
			$("#img_error").show().delay(3000).hide(0);
			return false;
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
								新增用户 <small>User registration</small>
							</h1>
						</div>
						<form onsubmit="return judge()" enctype="multipart/form-data"
							action="<c:url value='/UserServlet?method=addUser'/>"
							method="post">
							<div id="userinfo">
								<div class="divv">
									<span> 用户名 :<input type="text" id="gusername"
										name="gusername" value="${user.gusername }" />
									</span> <span id="egname"></span><span style="color: #FF0033">${msg }</span>
								</div>
								<div class="divv">
									<span> 邮&nbsp&nbsp&nbsp&nbsp&nbsp箱:<input type="text"
										id="gmail" name="gmail" value="${user.gmail }" />
									</span> <span id='email_error' class='error'>**邮箱格式不正确!</span>
								</div>
								<div class="divv">
									<span> 手&nbsp&nbsp&nbsp&nbsp&nbsp机:<input type="text"
										id="gtel" name="gtel" value="${user.gtel }" />
									</span><span id='tel_error' class='error'>**电话号码格式不正确!</span>
								</div>
								<div class="divv">
									<span> 头&nbsp&nbsp&nbsp&nbsp&nbsp像:<input type="file"
										id="gimage" name="gimage" value="${user.gimage }" />
									</span><span id='img_error' class='error'>**请填写用户头像!</span>
								</div>
								<div class="divv">
									<span> 签&nbsp&nbsp&nbsp&nbsp&nbsp名:<input type="text"
										maxlength="13" id="gtitle" name="gtitle"
										value="${user.gtitle }" />
									</span> <span id="etitle"></span>
								</div>
								<div class="divv">
									<span>级 &nbsp&nbsp&nbsp&nbsp&nbsp别: <select id="level"
										name="level" style="width: 100px;">
											<option value="1">管理员</option>
											<option value="2">高级会员</option>
											<option value="3" selected>普通会员</option>
									</select>
									</span> <span style="margin-left: 20px">性别:<input type="radio"
										name="gsex" id="gsex" class="input-xlarge" style="width: 30px"
										checked="checked" value="男" />男 <input type="radio"
										name="gsex" style="width: 30px" id="gsex" class="input-xlarge"
										value="女" />女
									</span>
								</div>
								<div class="form-actions">
									<input type="submit" class="btn btn-success btn-large"
										id="send_message" value="Save User" /> <a class="btn"
										href="http://localhost:8080/Gx/UserServlet?method=findAll">Cancel</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>

			<hr>
		</div>
		<div style="bottom: 0; position: fixed; width: 100%">
			<%@include file="/adminjsps/foot.jsp"%>
		</div>
	</c:if>
	<c:if test="${sessionScope.level!=1}">
		<h1 style="text-align: center">你没有权限访问此页面</h1>
	</c:if>
</body>
</html>
