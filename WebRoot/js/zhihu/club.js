$(function() { // 更改父标签点击样式
	$('.zm-topic-cat-item a').each(function() {
		/* alert($($(this))[0].href==String(window.location)); */
		if ($($(this))[0].href == String(window.location))
			$(this).parent().addClass('current');
	});
});

$(function() {
	$("[id='detail']").click(function(){
		//alert("hello");
		var clubid = $(this).parent().children("input").eq(2).val();
		//var focuscount=$("#"+clubid).text();
		var url="/Gx/ClubServlet?method=clubDetail&clubid="+clubid;
		url = encodeURI(url);		
		// $('body').load(url);
		// window.location = url;
		window.open(url);
	});  
	$(".zm-topic-cat-sub .follow, .notice-btn.ui-notice").click(function() {// 关注或取消关注,后台响应
		var val = $(this).parent().children("input").eq(0).val();
		var userid = $(this).parent().children("input").eq(1).val();
		var clubid = $(this).parent().children("input").eq(2).val();
		
		if ($.trim($(this).text()) == "关注") {
			$(this).text('取消关注');
			val = 0;
		} else {
			$(this).text('关注');
			val = 1;
		}

		$.ajax({
			url : 'http://localhost:8080/Gx/ClubServlet?method=focus',
			dataType : 'json',
			type : "get",
			data : {
				"value" : val,
				"userid" : userid,
				"clubid" : clubid
			},
			success : function(info) {
				var userclubcount = eval(info.userclubcount);
				var clubCount=eval(info.clubCount);
				$("#focusNum").text("已关注" + userclubcount + " 个话题");
				$(".pagingCount").text(clubCount);
			},
			error : function() {						
				alert("error");
			}
		});

	});
});

	function searchclub() {// 搜索
		var q = $("#question").val();
		// alert($("#question").val() != "");
		window.location.replace("/Gx/ClubServlet?method=findAll&question=" + q);
		if ($("#question").val() != "") { // 为空不搜索
			alert("请稍等!");
			window.location.replace("/Gx/ClubServlet?method=findAll&question=" + q);
			} else {
				alert("请稍等!");
				// window.location.replace("/Gx/ClubServlet?method=findAll");
			}
		}
$(document).keydown(function(event) {
	if (event.keyCode == 13) { // 绑定回车
		$('#search').click();
	}
});
