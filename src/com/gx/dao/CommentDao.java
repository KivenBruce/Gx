package com.gx.dao;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.log4j.Logger;

import com.gx.entity.Comment;
import com.gx.pager.ClubConstants;
import com.gx.pager.PageBean;

import cn.itcast.jdbc.TxQueryRunner;

public class CommentDao {
	private QueryRunner qr = new TxQueryRunner();
	int ps = ClubConstants.COMMENT_PAGE_SIZE;// 每页记录数;
	Logger log=Logger.getLogger(this.getClass());

	/**
	 * 查找所有的评论
	 * 
	 * @param clubid
	 * @param pc
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Comment> getCommentList(String clubid, int pc) throws SQLException {
		String sql = "select comment.* ,guser.gimage,guser.gtitle from comment ,guser where club_id=? and comment.user_id=guser.id order by comment_time desc limit ?,?";
		String sql1 = "select count(*) from comment where club_id=?";
		Number num = (Number) qr.query(sql1, new ScalarHandler(), clubid);
		int tr = num.intValue();
		int pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
		if (pc >= pageCount) {
			pc = pageCount;
		}
		List<Comment> commentList = qr.query(sql, new BeanListHandler<Comment>(Comment.class), clubid, (pc - 1) * ps,
				ps);
		PageBean<Comment> commentBean = new PageBean<Comment>();
		commentBean.setBeanList(commentList);
		commentBean.setPageCount(pageCount);
		commentBean.setTr(tr);
		return commentBean;
	}

	/**
	 * 新增评论
	 * 
	 * @param comment
	 * @return
	 * @throws SQLException
	 */
	public void addComment(Comment comment) throws SQLException {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String commentDate = sdf.format(date);
		String sql = "insert into comment(user_id,club_id,content,comment_time,user_name) values (?,?,?,?,?)";
		Object[] params = { comment.getUser_id(), comment.getClub_id(), comment.getContent(), commentDate,
				comment.getUser_name() };
		qr.update(sql, params);
	}
	
	public int getCommentCount(int userid){
		 String sql="select count(*) from comment where user_id="+userid;
		 int commentCount = 0;
		 try {
			Number n=(Number) qr.query(sql, new ScalarHandler());
			if(n==null){
				commentCount=0;
			}else{
				commentCount=n.intValue();
			}
		} catch (SQLException e) {
			log.debug("获取用户总评论数失败!!!");
			e.printStackTrace();
		}
		return commentCount;
	}

	/**
	 * 根据评论id删除评论
	 * 
	 * @param commentid
	 * @throws SQLException
	 */
	public void deleteComment(String commentid) throws SQLException {
		String sql = "delete  from comment where id=" + commentid;
		qr.update(sql);
	}

	public void updateLikeCount(String commentid, int count, String flag, int userid) throws SQLException {
		String sql;//更新comment表中该条动态的点赞总数
		String sql1;//更新comment_like表中,该用户对该动态是否处于点赞功能
		String sql2;//判断comment_like表中,该用户对该动态是否曾经点赞,如果没有点过,则新增,如果点过赞,则更新语句
		sql = "update comment set like_count="+count+" where id=" + commentid;
		qr.update(sql);
		sql2="select is_like from comment_like where user_id="+userid+" and comment_id="+commentid;
		Number num=(Number) qr.query(sql2, new ScalarHandler());
		if(num!=null){//曾经点过赞
			if(flag.equals("1")){
				sql1="update comment_like set is_like=1 where user_id="+userid+" and comment_id="+commentid;
			}else{
				sql1="update comment_like set is_like=0 where user_id="+userid+" and comment_id="+commentid;
			}
			qr.update(sql1);
		}else{//从未点过赞
			sql1="insert into comment_like(user_id,comment_id,is_like) values(?,?,?)";
			Object[] params={userid,commentid,1};
			qr.update(sql1,params);
		}
		
		
	}

}
