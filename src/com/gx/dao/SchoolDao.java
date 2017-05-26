package com.gx.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.log4j.Logger;

import com.gx.entity.School;
import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;

import cn.itcast.jdbc.TxQueryRunner;


public class SchoolDao {
	private QueryRunner qr = new TxQueryRunner();
	int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;
	Logger log = Logger.getLogger(this.getClass());

	public PageBean<School> findAll(int pc, String datefrom, String dateto, String place, String type) {
		String sql = "select * from sch_active where Gtime>?  and Gtime<? and Gplace like ? and Gflag=" + type
				+ " ORDER BY Gtime desc limit ?,?";
		String sql1 = "select count(*) from sch_active where Gtime>? and Gtime<? and Gflag=" + type
				+ " and Gplace like ?";

		Number number = null;
		try {
			if (datefrom == null) {
				datefrom = "0";
				dateto = "default";
				place = "";
			} else if (datefrom.length() == 0) {
				if (dateto.length() == 0) {
					if (place.length() == 0) {
						datefrom = "0";
						dateto = "default";
						place = "";
					} else {
						datefrom = "0";
						dateto = "default";
					}
				} else if (place.length() == 0) {
					datefrom = "0";
					place = "";
				} else {
					datefrom = "0";
				}
			} else if (dateto.length() == 0) {
				if (place.length() == 0) {
					dateto = "default";
					place = "";
				} else {
					dateto = "default";
				}
			} else if (place.length() == 0) {
				place = "";
			}
			number = (Number) this.qr.query(sql1, new ScalarHandler(),
					new Object[] { datefrom, dateto, "%" + place + "%" });
			int tr = number.intValue();
			int pageCount = tr % this.ps == 0 ? tr / this.ps : tr / this.ps + 1;
			if (pc >= pageCount) {
				pc = pageCount;
			}
			List<School> listSchool = (List) qr.query(sql, new BeanListHandler<School>(School.class), datefrom, dateto,
					"%" + place + "%", (pc - 1) * ps, ps);
			PageBean<School> pb = new PageBean<School>();

			pb.setBeanList(listSchool);
			pb.setPc(pc);
			pb.setPs(this.ps);
			pb.setTr(tr);
			pb.setPageCount(pageCount);
			pb.getPageCount();
			return pb;
		} catch (SQLException e) {
			log.debug("后台查找所有活动失败!!!");
			throw new RuntimeException(e);
		}
	}

	public School findById(String Gid) {
		String sql = "select * from sch_active where id=?";
		try {
			return (School) this.qr.query(sql, new BeanHandler<School>(School.class), Gid);
		} catch (SQLException e) {
			log.debug("后台根据id查询活动详情失败!!!");
			throw new RuntimeException(e);
		}
	}

	public void addSchool(School school) {
		String sql = "insert into sch_active(Gtheme,Gpart,Gtime,Gcontent,Gusername,Gperson,Gremain,Gtupian,Gprice,Gplace,Gflag)values(?,?,?,?,?,?,?,?,?,?,?)";
		Object[] params = { school.getGtheme(), school.getGpart(), school.getGtime(), school.getGcontent(),
				school.getGusername(), Integer.valueOf(school.getGperson()), school.getGremain(), school.getGtupian(),
				school.getGprice(), school.getGplace(),school.getGflag() };
		try {
			this.qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void delete(String gid) {
		String sql = "delete from sch_active where id=?";
		try {
			this.qr.update(sql, gid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void editSchool(School school, String gid) {
		String sql = "update sch_active set Gtheme=?,Gpart=? ,Gtime=? ,Gcontent=? ,Gusername=?,Gperson=?,Gremain=?,Gprice=?,Gplace=? ,Gtupian=? where id=?";
		Object[] params = { school.getGtheme(), school.getGpart(), school.getGtime(), school.getGcontent(),
				school.getGusername(), Integer.valueOf(school.getGperson()), school.getGremain(), school.getGprice(),
				school.getGplace(), school.getGtupian(), gid };
		try {
			this.qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
