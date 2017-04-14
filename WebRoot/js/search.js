$(document).ready(function() {//用户count显示与隐藏
	var time = null;
	$('#count').hover(function() {
		$("#countinfo").css('display', 'block');
	}, function() {
		time = setTimeout(function() {
			$("#countinfo").css('display', 'none')
		}, 200);
	});
	$("#countinfo").hover(function() {
		clearTimeout(time);
		$(this).css('display', 'block');
	}, function() {
		$(this).css('display', 'none');
	});
});

$(window).scroll(function() {/* 弹框搜索栏位置 */
	var st = $(this).scrollTop();
	if (st == 0) {
		$('#q').css({
			"margin-top" : "52px",
			"margin-left" : "60px"
		});
		$("#count").css("margin-top","50px");
		$("#countinfo").css("margin-top","-35px");
	} else {
		$('#q').css({
			"margin-top" : "25px",
			"margin-left" : "220px"
		});
		$("#count").css("margin-top","20px");
		$("#countinfo").css("margin-top","-62px");
	}
});

function search() {
	var q = $("#q").val();
	if ($("#q").val() != "") {/* 为空不搜索 */
		var url = "/Gx" + '/FrontServlet?' + "method=searchAll&q=" + q;
		url = encodeURI(url);
		/* url=encodeURI(url); */
		/* $('body').load(url); */
		window.location = url;
	}
}
$(document).keydown(function(event) {
	if (event.keyCode == 13) { // 绑定回车
		$('#searchimg').click();
	}
});