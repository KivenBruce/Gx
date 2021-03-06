<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/adminjsps/";
	String type= request.getParameter("type");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<title>Cubic-新增活动</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Admin panel developed with the Bootstrap from Twitter.">
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<script src="../adminjsps/My97DatePicker/WdatePicker.js"></script>
<script src="js/jquery.js"></script>
<script src="js/judge.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../uedit/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../uedit/ueditor.all.min.js"></script>
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
							<c:if test="<%= type.equals(\"0\")%>">校内活动</c:if>
							<c:if test="<%= type.equals(\"1\")%>">校外活动</c:if>
							<c:if test="<%= type.equals(\"2\")%>">校内推荐活动</c:if>
							<c:if test="<%= type.equals(\"3\")%>">校外推荐活动</c:if>
							<small>新增信息</small>
							</h1>
						</div>
						<form onsubmit="return judge()"  enctype="multipart/form-data"
							action="<c:url value='/SchoolServlet?method=addSchool&type=<%=type%>'/>"
							method="post">

							<div class="divv">
								<span> 活动主题: <input type="text" id="gtheme" name="gtheme"
									value="${school.gtheme }" />
								</span><span> 举办单位: <input type="text" id="gpart" name="gpart"
									value="${school.gpart }" />
								</span> <span> 举办时间 :<input type="text" id="gtime" name="gtime"
									value="${school.gtime }"
									onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm' })"
									autocomplete="off" />

								</span>
							</div>
							<div class="divv">
								<span> 举办地点 :<input type="text" id="gplace" name="gplace"
									value="${school.gplace }" />
								</span> <span> 举 &nbsp办 &nbsp者 :<input type="text"
									id="gusername" name="gusername" value="${school.gusername }" />
								</span> <span> 所需人数: <input type="text" id="gperson"
									name="gperson" value="${school.gperson }" />
								</span>
							</div>
							<div class="divv">
								<span> 图片:<input type="file" id="gtupian" name="gtupian"
									value="${school.gtupian}" />
								</span> <span style="margin-left: 35px"> 活动类型 :<input
									type="text" id="gremain" name="gremain"
									value="${school.gremain }" />
								</span> <span> 门票|每人 :<input type="text" id="gprice"
									name="gprice" value="${school.gprice }" />
								</span>
							</div>
							<div class="divv">
								<span>举办内容:<span id="errorinfo"
									style='padding-left: 22px; color: #FF0033'></span>
									<div style="width: 680px; margin-top: 15px">
										<script id="editor" type="text/plain"></script>
									</div>
									<input name="type" value="<%=type%>" type="hidden" />
								</span> <input id="gcontent" name="gcontent" type="hidden"></input>
							</div>
							<div
								style="float: right; margin-right: 190px; margin-top: -80px;">
								<input type="submit" class="btn btn-success btn-large"
									value="Save Changes" id="tj" /> <a class="btn"
									href="http://localhost:8080/Gx/SchoolServlet?method=findAll">Cancel</a>
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
		UEDITOR_CONFIG.UEDITOR_HOME_URL = '../uedit/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息 
		var editor = UE.getEditor('editor');
	</script>
</body>
</html>
