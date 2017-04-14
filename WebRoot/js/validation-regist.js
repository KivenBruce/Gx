$(document)
		.ready(
				function() {
					$('#send_message')
							.click(
									function(e) {
										var error = false;
										var name = $('#name').val();
										var pwd = $('#pwd').val();
										var email = $('#email').val();
										var tel = $('#tel').val();
										/* var xing = $('#xing').val(); */
										var pwd2 = $('#pwd2').val();

										// Form field validation
										if (name.length == 0) {
											var error = true;
											$('#name_error').show().delay(3000)
													.hide(0);
										} else {
											$('#name_error').fadeOut(500);
										}

										if (pwd.length > 30) {
											var error = true;
											$('#longpwd_error').show().delay(
													3000).hide(0);
										} else {
											$('#longpwd_error').fadeOut(500);
										}
										if (pwd.length < 6) {
											var error = true;
											$('#longpwd_error').show().delay(
													3000).hide(0);
										} else {
											$('#longpwd_error').fadeOut(500);
										}
										if (pwd.length == 0
												|| !(pwd.trim() == pwd2.trim())) {
											var error = true;
											$('#pwd2_error').show().delay(3000)
													.hide(0);
										} else {
											$('#pwd2_error').fadeOut(500);
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

										/*
										 * if(xing.length > 10){ var error =
										 * true; $('#xing_error').fadeIn(500);
										 * }else{ $('#xing_error').fadeOut(500); }
										 */										
										if (error == false) {
											// alert("您确定要注册吗？");
											var con = confirm("您确定要注册吗？");
											if (con) {
												return true;
											}

										}
										return false;
									});
				});