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
<title>Cubic-活动编辑</title>
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
							<c:if test="${type=='inschool' }">校内推荐活动</c:if>
							<c:if test="${type=='outschool' }">校推荐外活动</c:if>
							 <small>更新信息</small>
						</h1>
					</div>

					<c:if test="${fn:length(type)>8 }">
						<c:set var="gotos"
							value='/OutServlet?method=editSchool&gid=${gid}' />
					</c:if>
					<c:if test="${fn:length(type)<9 }">
						<c:set var="gotos"
							value='/InServlet?method=editSchool&gid=${gid}' />
					</c:if>

					<form action="<c:url value='${ gotos}'/>" method="post">

						<fieldset>
							<div class="divv">
								<span> 活动主题: <input type="text" id="gtheme" name="gtheme"
									value="${school.gtheme }" />
								</span> <span> 举办单位: <input type="text" id="gpart" name="gpart"
									value="${school.gpart }" />
								</span>
							</div>
							<div class="divv">
								<span> 举办时间 :<input type="text" id="gtime" name="gtime"
									value="${school.gtime }"
									onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm' })"
									autocomplete="off" />

								</span> <span> 举办地点 :<input type="text" id="gplace"
									name="gplace" value="${school.gplace }" />

								</span>
							</div>
							<div class="divv">
								<span> 举 &nbsp办 &nbsp者 :<input type="text" id="gusername"
									name="gusername" value="${school.gusername }" />

								</span> <span> 所需人数: <input type="text" id="gperson"
									name="gperson" value="${school.gperson }" />

								</span>
							</div>
							<div class="divv">
								<span> 图片:<input type="file"
									id="tupian" name="tupian"/>
								<input id="gtupian" name="gtupian" type="hidden" value="${school.gtupian }"/>
								</span> <span style="margin-left: 35px"> 活动类型 :<input
									type="text" id="gremain" name="gremain"
									value="${school.gremain }" />

								</span>
							</div>
							<div class="divv">
								<span> 门票|每人 :<input type="text" id="gprice"
									name="gprice" value="${school.gprice }" />

								</span>
								<span>举办内容:<textarea id="gcontent"
									name="gcontent">								
									</textarea>
								</span>
								<input id="inpp" type="hidden" value="${school.gcontent }"/>
								
							</div>
							<c:if test="${fn:length(type)<9 }">
								<div class="form-actions">
									<input type="submit" class="btn btn-success btn-large"
										value="Save Changes" /> <a class="btn"
										href="http://localhost:8080/Gx/InServlet?method=findAll">Cancel</a>
								</div>
							</c:if>
							<c:if test="${fn:length(type)>8 }">
								<div class="form-actions">
									<input type="submit" class="btn btn-success btn-large"
										value="Save Changes" /> <a class="btn"
										href="http://localhost:8080/Gx/OutServlet?method=findAll">Cancel</a>
								</div>
							</c:if>
						</fieldset>
					</form>
				</div>
			</div>
		</div>

		<hr>

		<%@include file="/adminjsps/foot.jsp"%>

	</div>
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
	$(function(){
		document.getElementById('gcontent').value=document.getElementById('inpp').value;
	});
	</script>
</body>
</html>
