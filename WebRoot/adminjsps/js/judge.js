function judge() {
	$("#errorinfo").show().delay(3000).hide(0);
	$("#errorinfo").text("");
	if ($.trim($("#gtheme").val()) == "") {
		document.getElementById("errorinfo").innerHTML = " **请填写活动主题!";
		return false;
	} 
	if ($.trim($("#gpart").val()) == "") {
		document.getElementById("errorinfo").innerHTML = " **请填写举办单位！";
		return false;
	}
	if ($.trim($("#gtime").val()) == "") {
		document.getElementById("errorinfo").innerHTML = " **请填写举办时间！";
		return false;
	}
	if ($.trim($("#gplace").val()) == "") {
		document.getElementById("errorinfo").innerHTML = "**请填写活动地点！";
		return false;
	} 
	if ($.trim($("#gusername").val()) == "") {
		document.getElementById("errorinfo").innerHTML = " **请填写举办人！";
		return false;
	} 
	if ($.trim($("#gperson").val()) == "") {
		document.getElementById("errorinfo").innerHTML = "**请填写活动人数！";
		return false;
	}
	if ($.trim($("#gtupian").val()) == "") {
		document.getElementById("errorinfo").innerHTML = "**请填写活动图片！";
		return false;
	} 
	if ($.trim($("#gremain").val()) == "") {
		document.getElementById("errorinfo").innerHTML = "**请填写活动类型！";
		return false;
	}
	if ($.trim($("#gprice").val()) == "") {
		document.getElementById("errorinfo").innerHTML = " **请填写门票价格！";
		return false;
	} 
	if($("#flag").val()=="123"){
		if($.trim($("#gurl").val())==""){
			document.getElementById("errorinfo").innerHTML = " **请填写链接地址！";
			return false;
		}
	}
		
	if(editor.getContent()==""||editor.getContent()==null){//editor.getContent().replace(/(&nbsp;)|\s|\u00a0/g, '')==""||editor.getContent().replace(/(&nbsp;)|\s|\u00a0/g, '')==null
		alert("请填写内容!");
		return false;
	} else if (editor.getContentLength(true) < 10) {
		alert("文章内容不得少于10个字符！");
		return false;
	}else{
		$("#gcontent").val(editor.getContent());
		return true;
	}

	
}
