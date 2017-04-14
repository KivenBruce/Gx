function judge() {
	if ($.trim($("#gtheme").val()) == "") {
		document.getElementById("egtheme").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动主题！</span>";
		return false;
	} else {
		document.getElementById("egtheme").innerHTML = "";
	}
	if ($.trim($("#gpart").val()) == "") {
		document.getElementById("egpart").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写举办单位！</span>";
		return false;
	} else {
		document.getElementById("egpart").innerHTML = "";
	}
	if ($.trim($("#gtime").val()) == "") {
		document.getElementById("egtime").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写举办时间！</span>";
		return false;
	} else {
		document.getElementById("egtime").innerHTML = "";
	}
	if ($.trim($("#gplace").val()) == "") {
		document.getElementById("egplace").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动地点！</span>";
		return false;
	} else {
		document.getElementById("egplace").innerHTML = "";
	}
	if ($.trim($("#gusername").val()) == "") {
		document.getElementById("egusername").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写主持人！</span>";
		return false;
	} else {
		document.getElementById("egusername").innerHTML = "";
	}
	if ($.trim($("#gperson").val()) == "") {
		document.getElementById("egperson").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动人数！</span>";
		return false;
	} else {
		document.getElementById("egperson").innerHTML = "";
	}
	if ($.trim($("#gtupian").val()) == "") {
		document.getElementById("egtupian").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动图片！！</span>";
		return false;
	} else {
		document.getElementById("egtupian").innerHTML = "";
	}
	if ($.trim($("#gremain").val()) == "") {
		document.getElementById("egremain").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动类型！</span>";
		return false;
	} else {
		document.getElementById("egremain").innerHTML = "";
	}
	if ($.trim($("#gprice").val()) == "") {
		document.getElementById("egprice").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写门票价格！</span>";
		return false;
	} else {
		document.getElementById("egprice").innerHTML = "";
	}
	if ($.trim($("#gcontent").val()) == "") {
		document.getElementById("egcontent").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写活动详细！</span>";
		return false;
	} else {
		document.getElementById("egcontent").innerHTML = "";
	}
	if(($.trim($("#gurl").val())==""||$.trim($("#gurl").val())=="0")&&$("#radio").is(':checked')){
		document.getElementById("egurl").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写链接地址！</span>";
		return false;
	}else{
		document.getElementById("egurl").innerHTML = "";
	}
}
