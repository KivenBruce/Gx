<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>Cubic-活动编辑</title>
<meta name="author" content="travis">
<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<script src="adminjsps/js/jquery.js"></script>
<script type="text/javascript" charset="utf-8"
	src="uedit/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="uedit/ueditor.all.min.js"></script>

</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="row-fluid">
				<span>neirong:</span>
				<div>
					<script id="editor" type="text/plain"></script>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	UEDITOR_CONFIG.UEDITOR_HOME_URL = './uedit/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息 
	var editor = UE.getEditor('editor');
</script>
</body>
</html>
