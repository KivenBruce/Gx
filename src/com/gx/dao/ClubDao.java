package com.gx.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.log4j.Logger;
import com.gx.entity.Club;
import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;

import cn.itcast.jdbc.TxQueryRunner;

public class ClubDao {
	private QueryRunner qr = new TxQueryRunner();
	Logger log = Logger.getLogger(this.getClass());

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
		if (isexist != null) {// 已经关注过,更新操作
			if (value == 0) {// 点击关注
				sql = "update club set isfocus=1 where club_id=" + club.getClub_id() + " and user_id=" + userid;
			} else {// 取消关注
				sql = "update club set isfocus=0 where club_id=" + club.getClub_id() + " and user_id=" + userid;
			}
			qr.update(sql);
		} else {
			sql = "insert into club(club_name,club_id,user_id,isfocus,gflag,club_parent,parent_id"
					+ ",club_image,club_desc,club_hoster) values(?,?,?,?,?,?,?,?,?,?)";
			Object[] params = { club.getClub_name(), club.getClub_id(), userid, 1, club.getGflag(),
					club.getClub_parent(), club.getParent_id(), club.getClub_image(), club.getClub_desc(),
					club.getClub_hoster() };
			try {
				this.qr.update(sql, params);
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}

		}
	}

	/**
	 * 查询每个club总关注数量 {[club_id,count],[club_id,count],,,,}
	 * 
	 * @param flag
	 * @param parentid
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public List<Map<String, Object>> findCount() throws SQLException {
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
	 * 查询用户关注的club的详细信息
	 * 
	 * @param flag
	 * @param parentid
	 * @param id
	 * @param question
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Club> findByUserId(int id) throws SQLException {
		String sql = "select * from club where user_id=" + id + " and isfocus=1";
		List<Club> listClub = qr.query(sql, new BeanListHandler<Club>(Club.class));
		PageBean<Club> pb = new PageBean<Club>();
		pb.setBeanList(listClub);
		return pb;
	}

	/**
	 * 根据userid查找用户点赞数
	 * 
	 * @param userid
	 * @return
	 */
	public int findLikeCountById(int userid) {
		String sql = "select sum(like_count) from comment where user_id=" + userid;
		int likecount = 0;
		try {
			Number n = (Number) qr.query(sql, new ScalarHandler());
			if (n != null) {
				likecount = n.intValue();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.debug("查找用户总点赞数出错!!!!!!!");
			e.printStackTrace();
		}
		return likecount;
	}

	/**
	 * 查询用户已关注的clubId编号以及数量.size {club_idclub_id,,,,}
	 * 
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
	 * 2017.4.13修改bug,之前没有根据userid查询,多个用户关注club的时候,结果不唯一 根据club_id查询club详细信息
	 * {clubdetail}
	 * 
	 * @param clubid
	 * @return
	 * @throws SQLException
	 */
	public Club selectInfoByCId(String clubid, int userid) throws SQLException {
		String sql = "select * from club where club_id=" + clubid + " and user_id=" + userid + " GROUP BY club_id";
		Club club = (Club) qr.query(sql, new BeanHandler<>(Club.class));
		if (club == null) {// 用户没有关注这个club
			String sql1 = "select * from club where club_id=" + clubid + " GROUP BY club_id";
			Club club1 = (Club) qr.query(sql1, new BeanHandler<>(Club.class));
			club1.setIsfocus(0);
			return club1;
		} else {
			return club;
		}

	}

	/**
	 * 查找单独club关注数量
	 * 
	 * @param clubid
	 * @return{clubcount}
	 * @throws SQLException
	 */
	public Number searchCountById(String clubid) throws SQLException {
		String sql = "select count(*) as count from  club where isfocus=1 and club_id=" + clubid + " GROUP BY club_id";
		Number num = (Number) qr.query(sql, new ScalarHandler());
		return num;
	}

	/**
	 * 查找热点club
	 * 
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Club> findHot() throws SQLException {
		String sql = "select * from  club where isfocus=1 GROUP BY club_id order by count(*) desc limit 3";
		List<Club> hotpb = qr.query(sql, new BeanListHandler<Club>(Club.class));
		PageBean<Club> pb = new PageBean<Club>();
		pb.setBeanList(hotpb);
		return pb;
	}

	/**
	 * 根据commentid与userid判断是否已经点赞
	 * @param commentid
	 * @param userid
	 * @return
	 * @throws SQLException
	 */
	public int selectIsLike(int commentid, int userid) throws SQLException {
		int likeflag;
		String sql = "select is_like from comment_like where user_id=" + userid + " and comment_id=" + commentid;
		Number num = (Number) qr.query(sql, new ScalarHandler());
		if (num != null && num.intValue() > 0) {
			likeflag = 1;
		} else {
			likeflag = 0;
		}
		return likeflag;
	}

	/**
	 * 管理员管理club
	 * @param question
	 * @param curPage
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Club> findByAdmin(String question, String curPage) throws SQLException {
		int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;
		Number number = null;// 总记录条数
		int tr = 0;// 总记录条数
		int pageCount = 0;// 页数
		String sql = "select * from club where club_name like ?  group by club_id limit ?,?";
		String sql1 = "select count(*) from (select * from club where club_name like ? GROUP BY club_id)as tess";
		if (curPage == null) {
			curPage = "1";
		}
		int page = Integer.parseInt(curPage);
		if (page < 0) {
			page = 1;
		}
		if (question == null) {
			question = "";
		}
		number = (Number) this.qr.query(sql1, new ScalarHandler(), "%" + question + "%");
		tr = number.intValue();
		pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
		if (page >= pageCount) {
			page = pageCount;
		}
		List<Club> listClub = qr.query(sql, new BeanListHandler<Club>(Club.class), "%" + question + "%",
				(page - 1) * ps, ps);
		PageBean<Club> pb = new PageBean<Club>();
		pb.setBeanList(listClub);
		pb.setPc(page);
		pb.setPs(ps);
		pb.setTr(tr);
		pb.setPageCount(pageCount);
		return pb;
	}

	/**
	 * 根据club_id查看club详细
	 * @param gid
	 * @return
	 * @throws SQLException
	 */
	public Club findById(String gid) throws SQLException {
		String sql = "select * from club where club_id=?  GROUP BY club_id";
		Club club = qr.query(sql, new BeanHandler<Club>(Club.class), gid);
		return club;
	}

	/**
	 * 查看所有clubparent
	 * @return
	 * @throws SQLException
	 */
	public List<Map<String, Object>> findClubParent() throws SQLException {
		String sql = "select parent_id,club_parent from club  GROUP BY parent_id";
		List<Map<String, Object>> list = qr.query(sql, new MapListHandler());
		return list;
	}

	/**
	 * 修改是否已经存在
	 * @param club
	 * @return
	 * @throws SQLException
	 */
	public String exist(Club club) throws SQLException {
		String sql = "select * from club where club_name=?";
		Club clubs = qr.query(sql, new BeanHandler<Club>(Club.class),club.getClub_name());
		if (clubs == null) {
			return "noexist";
		} else {
			return "exist";
		}
	}

	/**
	 * 编辑修改club
	 * @param club
	 * @param gid
	 * @throws SQLException
	 */
	public void editClub(Club club, String gid) throws SQLException {
		String sql = "update club set club_name=?,club_parent=?,parent_id=?,club_image=?,club_desc=?,club_hoster=?,gflag=? where club_id="
				+ gid;
		Object[] parm = { club.getClub_name(), club.getClub_parent(), club.getParent_id(),club.getClub_image(), club.getClub_desc(),
				club.getClub_hoster(), club.getGflag()};
		qr.update(sql,parm);
	}

	/**
	 * 删除club
	 * @param gid
	 * @throws SQLException
	 */
	public void deleteClub(String gid) throws SQLException {
		String sql="delete from club where club_id="+gid;
		qr.update(sql);
		
	}

}
