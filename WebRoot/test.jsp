<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE=html>
<html>
<head>
<script src="js/jquery.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var range = 10; //距下边界长度/单位px  
						var elemt = 200; //插入元素高度/单位px  
						var maxnum = 20; //设置加载最多次数  
						var num = 1;
						var totalheight = 0;
						var main = $("#content"); //主体元素  
						$(window)
								.scroll(
										function() {
											var srollPos = $(window)
													.scrollTop(); //滚动条距顶部距离(页面超出窗口的高度)  
											totalheight = parseFloat($(window)
													.height())
													+ parseFloat(srollPos);
											if (($(document).height() - range) <= totalheight
													&& num != maxnum) {
												main
														.append("<div style='border:1px solid tomato;margin-top:20px;color:#ac"
																+ (num % 20)
																+ (num % 20)
																+ ";height:"
																+ elemt
																+ "' >hello world"
																+ srollPos
																+ "---"
																+ num
																+ "</div>");
												num++;
											}
										});
					});
</script>
</head>
<body>
	<div id="content" style="height: 960px">
		<div id="follow">
			this is a scroll test;<br /> 页面下拉自动加载内容
		</div>
		<div
			style='border: 1px solid tomato; margin-top: 20px; color: #ac1; height: 800'>hello
			world test DIV</div>

	</div>
</body>
</html>
