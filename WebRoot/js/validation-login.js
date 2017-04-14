 $(document).ready(function(){
        $('#send_message').click(function(e){
            
            //Stop form submission & check the validation
            
        	/*var code='<%=session.getAttribute("code")%>'; 
        	alert(code);*/
            // Variable declaration
            var error = false;
            var name = $('#name').val();
            var pwd = $('#pwd').val();
            var lab1 = $('#lab1').val();
         	// Form field validation
            if(name.length == 0){
                var error = true;
                $('#name_error').show().delay(3000)
				.hide(0);
            }else{
                $('#name_error').fadeOut(500);
            }
            if(pwd.length == 0){
                var error = true;
                $('#pwd_error').show().delay(3000)
				.hide(0);
            }else{
                $('#pwd_error').fadeOut(500);
            }
            if(lab1.length == 0){
                var error = true;
                $('#lab1_error').show().delay(3000)
				.hide(0);
            }else{
                $('#lab1_error').fadeOut(500);
            }



             

            
            // If there is no validation error, next to process the mail function
            if(error == false){
                // Disable submit button just after the form processed 1st time successfully.
                 
                 return true;
 				/* Post Ajax function of jQuery to get all the data from the submission of the form as soon as the form sends the values to email.php*/
                 
             }
            return false;
        });    
    });