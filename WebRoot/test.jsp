<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta charset="utf-8" />
<title>Cubic-话题详情</title>

<link rel="shortcut icon" type="image/x-icon"
	href="http://localhost:8080/Gx/logo.ico" />
<link href="fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="css/zhihu.css">
<link rel="stylesheet" href="xiaodao/xiaodao.css">
<script src="js/jquery.min.js"></script>
<script src="js/zhihu/club.js"></script>
</head>
<body>
	<script type="text/javascript">
		/* $(document).ready(function() {
		 $(".notice-btn.ui-notice").click(function () {
		 alert("Hello!");
		 });
		 }); */
		$(function() {
			$(".notice-btn.ui-notice").click(function() {
				alert("Hello123!");
			});
		});
	</script>
	<div class="ui-community-header " id="communityHeader">
		<div class="ui-community-banner">
			<img src="xiaodao/img/banner-3a0ac30.png" alt="" width="100%">
		</div>
		<div class="ui-community-box">
			<div class="ui-community-detail">
				<h4>
					<span class="notice-btn ui-notice" style="cursor: pointer;">关注</span>
				</h4>

			</div>
		</div>
	</div>
</body>
</html>
