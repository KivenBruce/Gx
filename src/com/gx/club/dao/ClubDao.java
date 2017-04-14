package com.gx.club.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.gx.club.domain.Club;
import com.gx.club.domain.Comment;
import com.gx.pager.ClubConstants;
import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;

import cn.itcast.jdbc.TxQueryRunner;

public class ClubDao {
	private QueryRunner qr = new TxQueryRunner();


	/**
	 * 查询所有club
	 * 
	 * @param flag
	 * @param parentid
	 * @param id
	 * @param question
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Club> findAll(boolean flag, int parentid, int id, String question) throws SQLException {
		String sql;
		if (flag) {// 查找所有的club,每个用户进去的都是可以看见所有的club,所以不需要根据user_id查询.关注club时候需要根据user_id查询.
			sql = "select *, count(distinct club_name) from club  where parent_id=" + parentid + " group by club_name";
		} else {
			if (question == null) {
				sql = "select *, count(distinct club_name) from club group by club_name";
			} else {
				sql = "select * from club where club_name like '%" + question + "%' GROUP BY club_id";
			}

		}
		List<Club> listClub = qr.query(sql, new BeanListHandler<Club>(Club.class));
		PageBean<Club> pb = new PageBean<Club>();
		pb.setBeanList(listClub);
		return pb;
	}

	/**
	 * 每次点击关注与取消关注执方法
	 * 
	 * @param value
	 * @param club
	 * @param userid
	 * @throws SQLException
	 */
	public void changeFocus(int value, Club club, String userid) throws SQLException {
		// 首先应该判断用户之前是否关注过这个club,是做新增还是更新操作.如果之前没关注过,则要新增关注,如果之前关注过,则做更新
		String sql;
		String sql1 = "select * from club where user_id=" + userid + " and club_id=" + club.getClub_id();
		Club isexist = qr.query(sql1, new BeanHandler<Club>(Club.class));
		if (isexist!=null) {// 已经关注过,更新操作
			if (value == 0) {// 点击关注
				sql = "update club set isfocus=1 where club_id=" + club.getClub_id() + " and user_id=" + userid;
			} else {// 取消关注
				sql = "update club set isfocus=0 where club_id=" + club.getClub_id() + " and user_id=" + userid;
			}
			qr.update(sql);
		} else {
			sql = "insert into club(club_name,club_id,user_id,isfocus,gflag,club_parent,parent_id,comment_count,like_count"
					+ ",club_image,user_image,club_desc,club_hoster) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			Object[] params = { club.getClub_name(), club.getClub_id(), userid, 1, club.getGflag(),
					club.getClub_parent(),club.getParent_id(),0,0,club.getClub_image(),club.getClub_desc(),club.getClub_hoster()};
			try {
				this.qr.update(sql, params);
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}

		}

	}

	/**
	 * 查询每个club总关注数量
	 * {[club_id,count],[club_id,count],,,,}
	 * @param flag
	 * @param parentid
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<Map<String, Object>> findCount(boolean flag, int parentid, int id) throws SQLException {
		String sql = "select club_id,count(*) as count from  club where isfocus=1 GROUP BY club_id";
		List<Map<String, Object>> list = qr.query(sql, new MapListHandler());
		System.out.println(list);
		for (Map<String, Object> map : list) {
			System.out.println("-----------------");
			for (Map.Entry<String, Object> me : map.entrySet()) {
				System.out.println(me.getValue());
			}
		}

		return list;
	}

	/**
	 * 查询用户已关注的clubId编号以及数量.size
	 * {club_idclub_id,,,,}
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<Object[]> searchFocus(int id) throws SQLException {
		String sql = "select club_id from club where user_id=" + id + " and isfocus=1";
		List<Object[]> list;
		list = qr.query(sql, new ArrayListHandler());
		return list;
	}

	/**
	 * 2017.4.13修改bug,之前没有根据userid查询,多个用户关注club的时候,结果不唯一
	 * 根据club_id查询club详细信息
	 * {clubdetail}
	 * @param clubid
	 * @return
	 * @throws SQLException
	 */
	public Club selectInfoByCId(String clubid,int userid) throws SQLException {
		String sql = "select * from club where club_id=" + clubid +" and user_id="+userid+ " GROUP BY club_id";
		Club club = (Club) qr.query(sql, new BeanHandler<>(Club.class));
		if(club==null){//用户没有关注这个club
			String sql1="select * from club where club_id="+clubid+" GROUP BY club_id";
			Club club1=(Club) qr.query(sql1, new BeanHandler<>(Club.class));
			club1.setIsfocus(0);
			return club1;
		}else{
			return club;
		}
		
	}

	/**
	 * 查找单独club关注数量
	 * @param clubid
	 * @return{clubcount}
	 * @throws SQLException
	 */
	public Number searchCountById(String clubid) throws SQLException {
		String sql = "select count(*) as count from  club where isfocus=1 and club_id="+clubid+" GROUP BY club_id";
		Number num=(Number) qr.query(sql, new ScalarHandler());
		return num;
	}

	/**
	 * 查找热点club
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Club> findHot() throws SQLException {
		String sql="select * from  club where isfocus=1 GROUP BY club_id order by count(*) desc limit 3";
		List<Club> hotpb = qr.query(sql, new BeanListHandler<Club>(Club.class));
		PageBean<Club> pb = new PageBean<Club>();
		pb.setBeanList(hotpb);
		return pb;
	}

	public int selectIsLike(int commentid, int userid) throws SQLException {
		int likeflag;
		String sql="select is_like from comment_like where user_id="+userid+" and comment_id="+commentid;
		Number num=(Number) qr.query(sql, new ScalarHandler());
		if(num!=null&&num.intValue()>0){
			likeflag=1;
		}else{
			likeflag=0;
		}
		return likeflag;
	}

	

}
