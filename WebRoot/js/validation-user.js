$(document)
		.ready(
				function() {
					$('#send_message')
							.click(
									function(e) {
										var error = false;
										var email = $('#gmail').val();
										var tel = $('#gtel').val();									
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
												return true;										
										}else{
											return false;
										}
										
									});
				});