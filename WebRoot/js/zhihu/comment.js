function judge(){
	if(editor.getContent()==""||editor.getContent()==null){//editor.getContent().replace(/(&nbsp;)|\s|\u00a0/g, '')==""||editor.getContent().replace(/(&nbsp;)|\s|\u00a0/g, '')==null
		alert("请填写内容!");
		return false;
	} else if (editor.getContentLength(true) < 10) {
		alert("文章内容不得少于10个字符！");
		return false;
	}
	$("#content").val(editor.getContent());
	return true;
}

function confirmDelete(commentid){//删除评论
	//alert(commentid);
	if (confirm("你确认要删除这条活动?")) {
		$.ajax({
			url:'/Gx/ClubServlet?method=deleteComment',
			dataType : 'json',
			type:'get',
			data:{	
				"commentid":commentid
			},
			async : false,
			
			success:function(result){
				//window.location.reload();
				$("#"+commentid).hide();
			},error:function(){
				alert("error");
			}
		});	
	}
}
$(function(){//点赞变化
	$(".ui-action-box").click(function(){
		//alert("hello");
		var likeclass=$(this).children("a").children("em").attr("class");
		var likecount=$(this).children("a").children("b").text();
		commentid=$(this).children("input").val();
		var flag=0;
		if(likeclass=="ui-like"){
			 flag=-1;
			 $(this).children("a").children("em").attr("class","ui-like liked");
			 likecount=parseInt(likecount)-1;
			 $(this).children("a").children("b").text(likecount);		
		}else{
			 flag=1;
			 $(this).children("a").children("em").attr("class","ui-like");
			 likecount=parseInt(likecount)+1;
			 $(this).children("a").children("b").text(likecount);
		}
			$.ajax({
				url:'/Gx/ClubServlet?method=updateLikeCount',
				dataType : 'json',
				type:'get',
				data:{	
					"flag":flag,
					"likecount":likecount,
					"commentid":commentid
				},
				async : false,
				
				success:function(result){
					//alert("success update");
				},error:function(){
					alert("error");
				}
			});		
	});
	
	
});
