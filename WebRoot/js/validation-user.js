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
										var level=$('#level option:selected').val();
										
										
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
										if (error == false) {	
											if(typeof(level) == "undefined"){
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
													success : function(data) {
														if (data.info == "保存失败,该用户名已存在!") {
															alert(data.info);
														}else{
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