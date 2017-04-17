package com.gx.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.gx.entity.Navigate;
import com.gx.entity.School;
import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;

import cn.itcast.jdbc.TxQueryRunner;

public class FrontDao {
	private QueryRunner qr = new TxQueryRunner();
	int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;
	int listcount = PageConstants.PAGE_COUNT;

	public PageBean<School> listNew(String type) throws SQLException {
		String sql;
		if (type.equals("in")) {
			sql = "select  * from sch_active where gflag=0 order by Gtime desc";
		} else {
			sql = "select  * from sch_active where gflag=1 order by Gtime desc";
		}
		List<School> listSchool = qr.query(sql, new BeanListHandler<School>(School.class));
		PageBean<School> pb = new PageBean<School>();
		pb.setBeanList(listSchool);
		return pb;
	}

	public PageBean<School> listTui(String type) throws SQLException {
		String sql;
		if (type.equals("in")) {
			sql = "select  * from sch_active where gflag=2 order by Gtime desc";
		} else {
			sql = "select  * from sch_active where gflag=3 order by Gtime desc";
		}
		List<School> listSchool = qr.query(sql, new BeanListHandler<School>(School.class));
		PageBean<School> pb = new PageBean<School>();
		pb.setBeanList(listSchool);
		return pb;
	}

	public PageBean<Navigate> listNav(String type) throws SQLException {
		String sql;
		if (type.equals("in")) {
			sql = "select  * from nav_active where gflag=0 order by Gtime desc limit ?";
		} else {
			sql = "select  * from nav_active where gflag=1 order by Gtime desc limit ?";
		}
		List<Navigate> listnav = (List<Navigate>) qr.query(sql, new BeanListHandler<Navigate>(Navigate.class),
				listcount);
		PageBean<Navigate> pb = new PageBean<Navigate>();
		pb.setBeanList(listnav);
		return pb;
	}

	public <T> T searchById(String gid, String type) throws SQLException {
		String sql;
		String sql1;
		if (type.equals("nav")) {
			sql = "select * from nav_active n where  n.id=" + gid;
			Navigate nav = qr.query(sql, new BeanHandler<>(Navigate.class));
			return (T) nav;
		} else {
			sql = "select * from sch_active n where  n.id=" + gid;
			sql1 = "update sch_active set Gvisits=Gvisits+1 where id=" + gid;
			qr.update(sql1);
			School listSchool = (School) qr.query(sql, new BeanHandler<>(School.class));
			return (T) listSchool;
		}
	}

	public PageBean<School> searchAll(String gflag, int curPage, String question) throws SQLException {
		String plusi = " and i.gflag in(0,2)";
		String pluso = " and i.gflag in(1,3)";
		String sql1;
		String sql;
		if (gflag == null || gflag.equals("")) {
			sql = "select * from sch_active i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ?  order by Gtime desc limit ?,?";
			sql1 = "select count(*) from sch_active i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? ";
		} else if (gflag.equals("0")) {
			sql = "select * from sch_active i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? " + plusi
					+ " order by Gtime desc limit ?,?";
			sql1 = "select count(*) from sch_active i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? "
					+ plusi;
		} else {
			sql = "select * from sch_active i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? " + pluso
					+ " order by Gtime desc limit ?,?";
			sql1 = "select count(*) from sch_active i where CONCAT(i.Gcontent,i.Gplace,i.Gtheme,i.Gpart) like ? "
					+ pluso;
		}
		Number number = (Number) this.qr.query(sql1, new ScalarHandler(), new Object[] { "%" + question + "%" });
		int tr = number.intValue();
		int pageCount = tr % this.ps == 0 ? tr / this.ps : tr / this.ps + 1;
		if (curPage >= pageCount) {
			curPage = pageCount;
		}
		List<School> listSchool = (List<School>) this.qr.query(sql, new BeanListHandler<School>(School.class),
				new Object[] { "%" + question + "%", (curPage - 1) * ps, ps });
		PageBean<School> pb = new PageBean<School>();

		pb.setBeanList(listSchool);
		pb.setPc(curPage);
		pb.setPs(this.ps);
		pb.setTr(tr);
		pb.setPageCount(pageCount);
		pb.getPageCount();
		return pb;
	}

	public School searchByIdFlag(String gid) throws SQLException {
		String sql1;
		String sql;
		sql = "select * from sch_active i where i.id=? ";
		sql1 = "update sch_active set Gvisits=Gvisits+1 where id=" + gid;

		this.qr.update(sql1);
		School listSchool = (School) this.qr.query(sql, new BeanHandler<School>(School.class), gid);

		return listSchool;
	}

	public PageBean<School> moreActive(int pc, String type) throws SQLException {
		int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;
		int tr = 0;
		int pageCount = 0;
		String sql;
		String sql1;
		if (type.equals("in")) {
			sql = "select * from sch_active where gflag=0 order by Gtime desc limit ?,?";
			sql1 = "select count(*) from sch_active where gflag=0";
		} else if (type.equals("out")) {
			sql = "select * from sch_active where gflag=1 order by Gtime desc limit ?,?";
			sql1 = "select count(*) from sch_active where gflag=1";
		} else if (type.equals("intui")) {
			sql = "select * from sch_active where gflag=2 order by Gtime desc limit ?,?";
			sql1 = "select count(*) from sch_active where gflag=2";
		} else {
			sql = "select * from sch_active where gflag=3 order by Gtime desc limit ?,?";
			sql1 = "select count(*) from sch_active where gflag=3";
		}
		List<School> listschool = qr.query(sql, new BeanListHandler<School>(School.class), (pc - 1) * ps, ps);
		Number number = (Number) qr.query(sql1, new ScalarHandler());
		tr = number.intValue();
		pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
		if (pc >= pageCount) {
			pc = pageCount;
		}
		PageBean<School> pb = new PageBean<School>();
		pb.setBeanList(listschool);
		pb.setPc(pc);
		pb.setTr(tr);
		pb.setPageCount(pageCount);
		return pb;
	}

}
