package com.gx.user.dao;

import cn.itcast.jdbc.TxQueryRunner;

import java.sql.SQLException;
import java.util.List;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;
import com.gx.school.domain.School;
import com.gx.user.domain.User;

public class UserDao {
	private QueryRunner qr = new TxQueryRunner();

	public User login(String username, String password) throws SQLException {
		String sql = "select level from Guser where Gusername=? and Gpwd=?";

		return (User) this.qr.query(sql, new BeanHandler(User.class), new Object[] { username, password });
	}

	public User regist(String username) throws SQLException {
		String sql = "select * from Guser where Gusername=?";

		return (User) this.qr.query(sql, new BeanHandler(User.class), new Object[] { username });
	}

	@SuppressWarnings("unchecked")
	public PageBean<User> findAll(int pc, String username, String userlevel) throws SQLException {
		int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;
		List<User> listUser = null;
		Number number = null;// 总记录条数
		int tr = 0;// 总记录条数
		int pageCount = 0;// 页数
		String sql = null;
		String sql1 = null;
		if (username == null) {
			sql = "select * from guser order by gcreatetime desc limit ?,?";
			sql1 = "select count(*) from guser";
			number = (Number) this.qr.query(sql1, new ScalarHandler());
			tr = number.intValue();
			pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
			if (pc >= pageCount) {
				pc = pageCount;
			}
			listUser = (List<User>) qr.query(sql, new BeanListHandler(User.class), (pc - 1) * ps, ps);
		} else if (username.equals("")) {
			if (userlevel.equals("0") || userlevel.equals("")) {
				sql = "select * from guser order by gcreatetime desc limit ?,?";
				sql1 = "select count(*) from guser";
				number = (Number) this.qr.query(sql1, new ScalarHandler());
				tr = number.intValue();
				pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
				if (pc >= pageCount) {
					pc = pageCount;
				}
				listUser = (List<User>) qr.query(sql, new BeanListHandler(User.class), (pc - 1) * ps, ps);
			} else {
				sql = "select * from guser where level=? order by gcreatetime desc limit ?,?";
				sql1 = "select count(*) from guser where level=?";
				number = (Number) this.qr.query(sql1, new ScalarHandler(), userlevel);
				tr = number.intValue();
				pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
				if (pc >= pageCount) {
					pc = pageCount;
				}
				listUser = (List<User>) qr.query(sql, new BeanListHandler(User.class), userlevel, (pc - 1) * ps, ps);
			}
		} else {
			if (userlevel.equals("0") || userlevel.equals("")) {
				sql = "select * from guser where gusername=? order by gcreatetime desc limit ?,?";
				sql1 = "select count(*) from guser where gusername=?";
				number = (Number) this.qr.query(sql1, new ScalarHandler(), username);
				tr = number.intValue();
				pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
				if (pc >= pageCount) {
					pc = pageCount;
				}
				listUser = (List<User>) qr.query(sql, new BeanListHandler(User.class), username, (pc - 1) * ps, ps);
			} else {
				sql = "select * from guser where gusername=? and level=? order by gcreatetime desc";
				sql1 = "select count(*) from guser where gusername=? and level=?";
				number = (Number) this.qr.query(sql1, new ScalarHandler(), username, userlevel);
				tr = number.intValue();
				pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
				if (pc >= pageCount) {
					pc = pageCount;
				}
				listUser = (List<User>) qr.query(sql, new BeanListHandler(User.class), username, userlevel,
						(pc - 1) * ps, ps);
			}
		}

		PageBean<User> pb = new PageBean();
		pb.setBeanList(listUser);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		pb.setPageCount(pageCount);
		pb.getPageCount();
		return pb;
	}

	public void level(String username, int lev, int levb) {
		String sql = "update Guser set level=level+? where Gusername=?";
		String sqllog = "insert into  role_log(username,levelbefore,action) values(?,?,?)";
		try {
			this.qr.update(sql, new Object[] { Integer.valueOf(lev), username });
			this.qr.update(sqllog, new Object[] { username, Integer.valueOf(levb), Integer.valueOf(lev) });
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public String addUser(User user) throws SQLException {
		String flag;
		String exist = exist(user);
		if (exist.equals("noexist")) {
			flag = "noexist";
			String sql = "insert into guser(Gusername, Gpwd,level, Gmail, Gtel) values(?,?,?,?,?)";
			Object[] params = { user.getGusername(), PageConstants.INITAL_PASSWORD, Integer.valueOf(user.getLevel()),
					user.getGmail(), user.getGtel() };
			try {
				this.qr.update(sql, params);
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
		} else {
			flag = "isexist";
		}
		return flag;
	}

	public String exist(User user) throws SQLException {
		String sql1 = "select * from guser where Gusername=?";
		User exist = (User) this.qr.query(sql1, new BeanHandler(User.class), user.getGusername());
		if (exist == null) {
			return "noexist";
		} else {
			return "exist";
		}

	}

	public void resetPass(User user, String passEncode) {
		String sql = "update guser set Gpwd=? where Gusername=?";
		try {
			this.qr.update(sql, new Object[] { passEncode, user.getGusername() });
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public void resetPass(String gid) {
		String sql = "update guser set Gpwd=? where id=?";
		try {
			this.qr.update(sql, PageConstants.INITAL_PASSWORD,gid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void editUser(User user, String gid) throws SQLException {
		String sql = "update guser set Gusername=?,level=?, Gmail=?, Gtel=? where id=?";
		try {
			qr.update(sql, user.getGusername(), user.getLevel(), user.getGmail(), user.getGtel(), gid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void delete(String gid) {
		String sql = "delete from guser where id=?";
		try {
			this.qr.update(sql, gid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public User findById(String gid) {
		String sql = "select * from guser where id=?";
		try {
			return (User) this.qr.query(sql, new BeanHandler(User.class), gid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public User findByName(String username) {
		String sql = "select * from guser where Gusername=?";
		try {
			return (User) this.qr.query(sql, new BeanHandler(User.class), username);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
