package com.gx.front.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.gx.front.domain.Navigate;
import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;
import com.gx.school.domain.School;
import com.gx.user.domain.User;

import cn.itcast.jdbc.TxQueryRunner;

public class FrontDao {
	private QueryRunner qr = new TxQueryRunner();
	int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;

	public PageBean<School> listNew(int pagecount, String type) throws SQLException {
		String sql;
		if (type.equals("in")) {
			sql = "select  * from inschool order by Gtime desc";
		} else {
			sql = "select  * from outschool order by Gtime desc";
		}
		List<School> listSchool = (List<School>) qr.query(sql, new BeanListHandler(School.class));
		PageBean<School> pb = new PageBean();
		pb.setBeanList(listSchool);
		return pb;
	}

	public PageBean<School> listTui(int pagecount, String type) throws SQLException {
		String sql;
		if (type.equals("in")) {
			sql = "select  * from intuijian order by Gtime desc";
		} else {
			sql = "select  * from outtuijian order by Gtime desc";
		}
		List<School> listSchool = (List<School>) qr.query(sql, new BeanListHandler(School.class));
		PageBean<School> pb = new PageBean();
		pb.setBeanList(listSchool);
		return pb;
	}

	public PageBean<Navigate> listNav(int pagecount, String type) throws SQLException {
		String sql;
		if (type.equals("in")) {
			sql = "select  * from inlist order by Gtime desc limit ?";
		} else {
			sql = "select  * from outlist order by Gtime desc limit ?";
		}
		List<Navigate> listnav = (List<Navigate>) qr.query(sql, new BeanListHandler(Navigate.class), pagecount);
		PageBean<Navigate> pb = new PageBean();
		pb.setBeanList(listnav);
		return pb;
	}

	public <T> T searchById(String gid, String type) throws SQLException {
		String sql = "select * from " + type + " i where i.id=? ";
		String sql1 = "update " + type + " set Gvisits=Gvisits+1 where id=" + gid;
		if (!type.equals("inlist") && !type.equals("outlist")) {
			this.qr.update(sql1);
		}

		if (type.contains("list")) {
			Navigate nav = qr.query(sql, new BeanHandler<>(Navigate.class), gid);
			return (T) nav;
		} else {
			School listSchool = (School) qr.query(sql, new BeanHandler(School.class), gid);
			return (T) listSchool;
		}
	}

	public PageBean<School> searchAll(String gflag, int curPage, String question) throws SQLException {
		String plusi = " and i.gflag=" + gflag;
		String pluso = " and o.gflag=" + gflag;
		String sql1;
		String sql;
		if (gflag == null||gflag.equals("")) {
			sql = "select * from inschool i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? UNION ALL select * from outschool o where CONCAT(o.Gcontent,o.Gplace,o.Gtheme,o.Gpart) like ? order by Gtime desc limit ?,?";
			sql1 = "select count(*) from (select i.Gcontent from inschool i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? UNION ALL select o.Gcontent from outschool o where CONCAT(o.Gcontent,o.Gplace,o.Gtheme,o.Gpart) like ?)as total";
		} else {
			sql = "select * from inschool i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? " + plusi
					+ " UNION ALL select * from outschool o where CONCAT(o.Gcontent,o.Gplace,o.Gtheme,o.Gpart) like ? "
					+ pluso + " order by Gtime desc limit ?,?";
			sql1 = "select count(*) from (select i.Gcontent from inschool i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? "
					+ plusi
					+ " UNION ALL select o.Gcontent from outschool o where CONCAT(o.Gcontent,o.Gplace,o.Gtheme,o.Gpart) like ?"
					+ pluso + ")as total";
		}
		Number number = (Number) this.qr.query(sql1, new ScalarHandler(),
				new Object[] { "%" + question + "%", "%" + question + "%" });
		int tr = number.intValue();
		int pageCount = tr % this.ps == 0 ? tr / this.ps : tr / this.ps + 1;
		if (curPage >= pageCount) {
			curPage = pageCount;
		}
		List<School> listSchool = (List<School>) this.qr.query(sql, new BeanListHandler<School>(School.class),
				new Object[] { "%" + question + "%", "%" + question + "%", Integer.valueOf((curPage - 1) * this.ps),
						Integer.valueOf(this.ps) });
		PageBean<School> pb = new PageBean<School>();

		pb.setBeanList(listSchool);
		pb.setPc(curPage);
		pb.setPs(this.ps);
		pb.setTr(tr);
		pb.setPageCount(pageCount);
		pb.getPageCount();
		return pb;
	}

	public School searchByIdFlag(String gid, String gflag) throws SQLException {
		String sql1;
		String sql;
		if (gflag.equals("0")) {
			sql = "select * from inschool i where i.id=? ";
			sql1 = "update inschool set Gvisits=Gvisits+1 where id=" + gid;
		} else {
			sql = "select * from outschool o where o.id=? ";
			sql1 = "update outschool set Gvisits=Gvisits+1 where id=" + gid;
		}
		this.qr.update(sql1);
		School listSchool = (School) this.qr.query(sql, new BeanHandler(School.class), gid);

		return listSchool;
	}

	public PageBean<School> moreActive(int pc, String type) throws SQLException {
		int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;
		int tr = 0;
		int pageCount = 0;
		String sql = "select * from " + type + " order by Gtime desc limit ?,?";
		String sql1 = "select count(*) from " + type;
		List<School> listschool = qr.query(sql, new BeanListHandler<School>(School.class), (pc - 1) * ps, ps);
		Number number = (Number) qr.query(sql1, new ScalarHandler());
		tr = number.intValue();
		pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
		if (pc >= pageCount) {
			pc = pageCount;
		}
		PageBean<School> pb = new PageBean();
		pb.setBeanList(listschool);
		pb.setPc(pc);
		pb.setTr(tr);
		pb.setPageCount(pageCount);
		return pb;
	}

}
