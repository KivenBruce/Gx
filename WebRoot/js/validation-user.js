$(function(){//取消与关注
	$(".notice").click(function(){
		$(this).parent().parent().parent().hide();
		var userid = $(this).parent().children("input").eq(0).val();
		var clubid = $(this).parent().children("input").eq(1).val();
		$.ajax({
			url:'/Gx/ClubServlet?method=focus',
			data:{
				"value":"1",
				"clubid":clubid,
				"userid":userid
			},
			type:'post',
			dataType:'json',
			success:function(data){
				$("#focuscount").text(data.userclubcount);
			},
			error:function(){
				alert("操作失败,请稍后重试!");
			}
		});
	});
});
	$(function() {//点击显示相应的页面
		for (var i = 1; i <= 3; i++) {
			(function(arg) {
				$("#i" + i).click(function(i) {
					$(".content-menu li").attr("class", "menu menu-item");
					$(this).attr("class", "menu menu-item active");
					$(".ui-user-item").hide();
					$("#q" + arg).show();
				});
			})(i);

		}
	});

$(document)
		.ready(
				function() {
					$('#send_message')
							.click(
									function(e) {
										var error = false;
										var email = $('#gmail').val();
										var tel = $('#gtel').val();
										var gid = $('#gid').val();
										var gimage = $("#gimage").val();
										var gusername = $("#gusername").val();
										var gtitle = $("#gtitle").val();
										var level = $('#level option:selected')
												.val();
										var u = $("#gusername").val();
										if (u == "") {
											var error = true;
											document.getElementById("egname").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写用户名！</span>";
											$("#egname").show().delay(2000)
													.hide(0);

										}
										var t = $("#gtitle").val();
										if (t == "") {
											var error = true;
											document.getElementById("etitle").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写个性签名！</span>";
											$("#etitle").show().delay(3000)
													.hide(0);
										}
										var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
										if (!filter.test(email)) {
											var error = true;
											$('#email_error').show()
													.delay(3000).hide(0);
										} else {
											$('#email_error').fadeOut(500);
										}

										var re = /^1\d{10}$/;
										if (!re.test(tel)) {
											var error = true;
											$('#tel_error').show().delay(3000)
													.hide(0);
										} else {
											$('#tel_error').fadeOut(500);
										}
										if (error == false) {//验证全部通过
											if (typeof (level) == "undefined") {//普通用户模式下修改,不包括修改级别
												$.ajax({
															type : "POST",
															dataType : "json",
															url : '/Gx/UserServlet?method=editAccount&gid='
																	+ gid,
															data : {
																"gusername" : gusername,
																"gmail" : email,
																"gtel" : tel,
																"gimage" : gimage,
																"gtitle" : gtitle
															},// 你的formid
															async : false,
															error : function(
																	request) {
																alert("Connection error");
															},
															success : function(
																	data) {
																if (data.info == "保存失败,该用户名已存在!") {
																	alert(data.info);
																} else {
																	alert("保存成功!");
																}
																$("#userimage")
																		.attr(
																				"src",
																				"ClubServlet?method=doImage&filepath="
																						+ data.userimage);
															}
														});
											}

										} else {
											return false;
										}

									});
				});