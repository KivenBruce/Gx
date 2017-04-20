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
<title>访问记录</title>
<th:block th:fragment="styles">
	<link href="../styles/layout.css" type="text/css" rel="stylesheet" />
	<link href="../styles/global.css" rel="stylesheet" type="text/css" />
	<link href="../styles/table.css" type="text/css" rel="stylesheet" />
	<link href="../adminjsps/css/bootstrap.css" rel="stylesheet">
	<link href="css/site.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.css" rel="stylesheet">
	<link rel="shortcut icon" type="image/x-icon"
		href="http://localhost:8080/Gx/logo.ico" />
</th:block>
<th:block th:fragment="scripts">
	<script src="../js/echarts.js"></script>
	<script src="../js/charts.js"></script>
	<!-- <script src="../js/esl.js"></script> -->
	<script src="../adminjsps/My97DatePicker/WdatePicker.js"></script>
	<script src="../adminjsps/js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function refresh() {
			// 基于准备好的dom，初始化echarts图表
			var myChart = echarts.init(document.getElementById('main'));
			var dateFrom = $("#dateFrom").val();
			var dateTo = $("#dateTo").val();
			var date3 = new Date(dateTo).getTime()
					- new Date(dateFrom).getTime() //时间差的毫秒数
			var days = Math.floor(date3 / (24 * 3600 * 1000));
			if (days > 31) {
				alert("查询时间只能相差一个月！");
				return;
			}

			$.ajax({
				type : "POST",
				url : "/Gx/UserServlet?method=visitData",
				data : {
					"datefrom" : dateFrom,
					"dateto" : dateTo,
				},
				async : false,
				dataType : 'json',
				success : function(reJson) {
					var option = {
						color : [ '#81affa', '#2ec7c9', '#b6a2de', '#5ab1ef',
								'#ffb980', '#d87a80', '#8d98b3', '#e5cf0d',
								'#97b552', '#95706d', '#dc69aa', '#07a2a4',
								'#9a7fd1', '#588dd5', '#f5994e', '#c05050',
								'#59678c', '#c9ab00', '#7eb00a', '#6f5553',
								'#c14089' ],
						title : {
							text : '访问量情况统计',
							subtext : reJson.nodata,
							subtextStyle : {
								fontSize : 16,
								fontWeight : 'bolder',
								color : 'red'
							},
							x : 'center',
							//paddingLeft: 5, 
							textStyle : {
								fontWeight : 'normal',
								fontFamily : '楷体'
							}
						},
						toolbox : {
							show : true,
							feature : {
								mark : {
									show : true
								},
								dataView : {
									show : true,
									readOnly : false
								},
								magicType : {
									show : true,
									type : [ 'line', 'bar' ]
								},
								restore : {
									show : true
								},
								saveAsImage : {
									show : true
								}
							}
						},
						tooltip : {
							trigger : 'axis'
						},
						calculable : true,
						legend : {
							x : 'left',
							data : [ '访问量', '处理失败量' ]
						},
						xAxis : [ {
							type : 'category',
							data : reJson.categories
						} ],
						yAxis : [ {
							type : 'value',
							name : '总访问量',
							axisLabel : {
								formatter : '{value} '
							}
						}
						/* ,
						{
						    type : 'value',
						    name : '处理失败量',
						    axisLabel : {
						        formatter: '{value} '
						    }
						} */
						],
						series : [

						{
							name : '总接收量',
							type : 'bar',
							/*  "itemStyle": {
							 	normal: {
							 		label : {show: true, position: "top"}
								}
							 }, */
							itemStyle : {

								normal : {
									barBorderRadius : 5
								},
								emphasis : {
									barBorderRadius : 5
								}
							},
							data : reJson.msgDaily
						} ]
					};
					// 为echarts对象加载数据 
					myChart.setOption(option);
				},
				error : function() {
					alert("异常！");
				}
			});
		}
	</script>
</th:block>

</head>
<body>
	<c:if test="${sessionScope.level==1}">
		<%@include file="../adminjsps/head.jsp"%>

		<div class="container-fluid">
			<div class="row-fluid">
				<%@include file="/adminjsps/left.jsp"%>
				<div th:fragment="content" class="span9">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td><img src="../images/icon_01.gif" /> <span
								style="width: 55px; font-size: 19px; vertical-align: middle">消息情况统计</span></td>
						</tr>
					</table>
					<table id="mainDataTable" style="width: 100%; margin-top: 5px;"
						cellspacing="0" border="0" cellpadding="0" class="Table_pw">
						<tr style="margin-top: 20px">
							<td align="center"><span
								style="font-size: 18px; vertical-align: middle">时间：</span><input
								class="Wdate" type="text" id="dateFrom" name="dateFrom"
								th:value="${dateFrom}"
								onFocus="WdatePicker({skin:'whyGreen',isShowClear:false,isShowWeek:true,maxDate:'#F{$dp.$D(\'dateTo\')||\'%y-%M-{%d-1}\'}'})" />&nbsp;
								- <input class="Wdate" type="text" id="dateTo" name="dateTo"
								th:value="${dateTo}"
								onFocus="WdatePicker({skin:'whyGreen',isShowClear:false,isShowWeek:true,minDate:'#F{$dp.$D(\'dateFrom\')||\'%y-%M-{%d-1}\'}'})" />&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="image"
								src="<%=basePath%>img/5.jpg" style="width: 40px; height: 24px;"
								onclick="refresh()" /></td>
						</tr>
						<tr style="height: 1px;">
							<td></td>
						</tr>
					</table>
					<hr />
					<table style="width: 100%; margin-top: 0px;" border="1px"
						cellspacing="0" cellpadding="0" class="Table_03">
						<tr>
							<td>
								<div id="main" style="height: 350px; border: 1px;"></div>
							</td>
						</tr>
					</table>
					<script type="text/javascript">
						refresh();
					</script>
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