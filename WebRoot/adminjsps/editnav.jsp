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
<script type="text/javascript" charset="utf-8"
	src="../uedit/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../uedit/ueditor.all.min.js"></script>
<script src="js/judge.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	function gd() {
		var value = document.getElementById("radio").checked;
		if (!value) {//选否
			$("#gurl").val("0");
			document.getElementById("gurl").disabled = true;
		} else {
			$("#gurl").val("");
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
								</span><span> 举办单位: <input type="text" id="gpart" name="gpart"
									value="${nav.gpart }" />
								</span> <span> 举办时间 :<input type="text" id="gtime" name="gtime"
									value="${nav.gtime }"
									onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm' })"
									autocomplete="off" />

								</span>
							</div>
							<div class="divv">
								<span> 举办地点 :<input type="text" id="gplace" name="gplace"
									value="${nav.gplace }" />
								</span> <span> 举 &nbsp办 &nbsp者 :<input type="text"
									id="gusername" name="gusername" value="${nav.gusername }" />
								</span> <span> 所需人数: <input type="text" id="gperson"
									name="gperson" value="${nav.gperson }" />
								</span>
							</div>
							<div class="divv">
								<span> 图片:<input type="file" id="tupian" name="tupian"
									value="${nav.gtupian}" /> <input type="hidden" id="gtupian"
									name="gtupian" value="${nav.gtupian}" />
								</span> <span style="margin-left: 35px"> 活动类型 :<input
									type="text" id="gremain" name="gremain" value="${nav.gremain }" />
								</span> <span> 门票|每人 :<input type="text" id="gprice"
									name="gprice" value="${nav.gprice }" />
								</span>
							</div>
							<div class="divv">
								<span>举办内容:<span id="errorinfo"
									style='padding-left: 22px; color: #FF0033'></span>
									<div style="width: 680px; margin-top: 15px">
										<script id="editor" type="text/plain">${nav.gcontent}</script>
									</div>
								</span> <input id="gcontent" name="gcontent" type="hidden" />
							</div>
							<div class="divv" style="float: right; margin-top: -215px;">
								<span> 是否为广告 : </span> <span><input id="radio" type=radio
									name=aa value="1" onclick="gd()" checked>是</span> <span><input
									id="radio" type=radio name=aa value="0" onclick="gd()">否</span>
								<br>
								<br> <span>广告链接:<input type="text"
									style="width: 50px" value="http://" disabled="disabled"><input
									type="text" id="gurl" name="gurl" value="${fn:substring(nav.gurl,7,fn:length(nav.gurl))}"/>
								</span><input type="hidden" value="123" id="flag"/>
							</div>
							<div
								style="float: right; margin-right: 190px; margin-top: -80px;">
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
	<script type="text/javascript">
		UEDITOR_CONFIG.UEDITOR_HOME_URL = '../uedit/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息 
		var editor = UE.getEditor('editor');
	</script>
</body>
</html>
