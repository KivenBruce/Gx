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
<title>Cubic-用户编辑</title>
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
<!-- 自定义js,判断是否合法输入 -->
<style type="text/css">
.error {
	border: none;
	display: none;
	color: #C03;
	font-size: 12px;
}


.divv {
	 font-size: 20px;
    padding-top: 15px;
}

.divv input {
	color: #997777;
	font-size: 18px;
	margin-left: 10px;
	width: 250px;
}
</style>

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
						<form onsubmit="return judge()" enctype="multipart/form-data"
							action="<c:url value='/UserServlet?method=editUser&gid=${gid}'/>"
							method="post">
							<div id="userinfo">
								<div class="divv">
									<span> 用户名 :<input type="text" id="gusername"
										name="gusername" value="${user.gusername }" />
									</span> <span id="egname"></span>
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
									</span>
									<span style="margin-left:-70px"> 默认:${user.gimage }
									</span><input type="hidden" id="defaultimg" name="defaultimg" value="${user.gimage }" />
								</div>
								<div class="divv">
									<span> 签&nbsp&nbsp&nbsp&nbsp&nbsp名:<input type="text" maxlength="13"
										id="gtitle" name="gtitle" value="${user.gtitle }" />
									</span> <span id="etitle"></span>
								</div>
								<div class="divv">
									<span>级 &nbsp&nbsp&nbsp&nbsp&nbsp别:										
											<select id="level" name="level" style="width: 250px;">
												<option value="1">管理员</option>
												<option value="2">高级会员</option>
												<option value="3" selected>普通会员</option>
											</select>										
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
			<%@include file="/adminjsps/foot.jsp"%>

		</div>
	</c:if>
	<c:if test="${sessionScope.level!=1}">
		<h1 style="text-align: center">你没有权限访问此页面</h1>
	</c:if>
</body>
</html>
