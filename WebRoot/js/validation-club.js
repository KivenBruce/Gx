$(document).ready(function() {
$('#send_message').click(function(e) {
var error = false;
var club_name = $('#club_name').val();
var club_hoster = $('#club_hoster').val();
var club_id = $("#club_id").val();
var club_parent=$("#clubparent").val();	
var parent=$("#club_parent").val();
if(club_parent!=parent){
	alert("请选择图片!");
	return false;
}
$("#gparent").val($("#clubparent").val());
if ($.trim(club_name) == "") {
document.getElementById("egname").innerHTML = "<span style='padding-left:22px;color:#FF0033'> **请填写Club名称！</span>";
$("#egname").show().delay(3000).hide(0);
return false;
}

if ($.trim(club_hoster)=="") {
$("#ehoster").show().delay(3000).hide(0);
return false;
}

if ($.trim(club_id)=="") {
$('#eid').show().delay(3000).hide(0);
return false;
}

if(editor.getContent()==""||editor.getContent()==null){
	alert("请填写内容!");
	return false;
} else if (editor.getContentLength(true) < 10) {
	alert("文章内容不得少于10个字符！");
	return false;
}else{
	$("#gcontent").val(editor.getContent());
	return true;
}

});
});