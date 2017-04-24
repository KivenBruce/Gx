<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>Cubic-club编辑</title>
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="adminjsps/css/bootstrap.css" rel="stylesheet">
<link href="adminjsps/css/site.css" rel="stylesheet">
<link href="adminjsps/css/bootstrap-responsive.css" rel="stylesheet">
<link href="fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<script src="adminjsps/js/jquery.js"></script>
<script src="adminjsps/js/bootstrap.min.js"></script>
<script src="js/validation-club.js"></script>
<script type="text/javascript" charset="utf-8"
	src="uedit/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="uedit/ueditor.all.min.js"></script>
<!-- 自定义js,判断是否合法输入 -->
<script type="text/javascript">
	$(function() {
		$("#clubparent option[value=${club.club_parent}]").attr("selected",
				"selected");	
	});
</script>
<style type="text/css">
.error {
	border: none;
	display: none;
	font-size: 20px;
	padding-left: 22px;
	color: #FF0033
}

.divv {
	font-size: 20px;
	padding-top: 15px;
}

.divv input {
	color: #997777;
	font-size: 15px;
	margin-left: 10px;
	width: 250px;
	font-weight: 600;
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
								修改Club <small>Club Edit</small>
							</h1>
						</div>
						<form onsubmit="return judge()" enctype="multipart/form-data"
							action="<c:url value='/ClubServlet?method=editClub&gid=${gid}'/>"
							method="post">
							<div id="userinfo">
								<div class="divv">
									<span> Club名称:<input type="text" id="club_name"
										name="club_name" value="${club.club_name }" />
									</span> <span id="egname"></span><span style="color: #FF0033">${msg }</span>
									<input type="hidden" id="club_parent" value="${club.club_parent }"/>
									<span style="margin-left: 40px"> Club 类型:<select
										id="clubparent"
										style="width: 250px; color: #997777; font-size: 15px; font-weight: 600;">
											<c:forEach var="keys" items="${mapcount }">
												<option value="${keys.value}">${keys.value}</option>
											</c:forEach>
									</select><input name="gparent" id="gparent" type="hidden" value=""/>
									</span>
									<span style="margin-left: 40px"> 
									<img alt="" src="ClubServlet?method=doImage&filepath=${club.club_image }&parentid=${club.parent_id}">
									</span>
								</div>
								<div class="divv">
									<span> 管 &nbsp理&nbsp 员:<input type="text"
										id="club_hoster" name="club_hoster"
										value="${club.club_hoster }" />
									</span><span id='ehoster' class='error'>**请填写管理员!</span> <span
										style="margin-left: 40px"> Club图片:<input type="file"
										id="club_image" name="club_image" value="${club.club_image}" />
									</span> <span style="margin-left: -70px"> 默认:${club.club_image }
									</span><input type="hidden" id="defaultimg" name="defaultimg"
										value="${club.club_image }" />
								</div>
								<div class="divv">
									<span>Club_id:&nbsp <input type="text" id="club_id" readonly="readonly"
										name="club_id" value="${club.club_id }" />
									</span><span id='eid' class='error'>**请填写ClubId!</span> <span
										style="margin-left: 40px">范围:<input type="radio"
										name="gflag" id="gflag" class="input-xlarge"
										style="width: 30px"
										<c:if test="${club.gflag eq '0' }">checked</c:if> value="0" />校内
										<input type="radio" name="gflag" style="width: 30px"
										id="gflag" class="input-xlarge"
										<c:if test="${club.gflag eq '1' }">checked</c:if> value="1" />校外
									</span>
								</div>
								<div class="divv">
									<span>Club描述:</span>
									<div id="gdesc" name="gdesc"
										style="width: 700px; margin-left: 90px; margin-top: -20px;">
										<script id="editor" type="text/plain">${club.club_desc}</script>
									</div>
								</div>
								<div class="form-actions">
									<input type="submit" class="btn btn-success btn-large"
										id="send_message" value="Save User" /> <a class="btn"
										href="http://localhost:8080/Gx/ClubServlet?method=findByAdmin">Cancel</a>
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
	<script type="text/javascript">
		UEDITOR_CONFIG.UEDITOR_HOME_URL = './uedit/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息 
		var editor = UE.getEditor('editor');
	</script>
</body>
</html>
