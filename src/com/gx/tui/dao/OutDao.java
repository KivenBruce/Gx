package com.gx.tui.dao;

import cn.itcast.jdbc.TxQueryRunner;

import java.sql.SQLException;
import java.util.List;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;
import com.gx.school.dao.accountID;
import com.gx.school.domain.School;

public class OutDao {
	private QueryRunner qr = new TxQueryRunner();
	int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;

	public PageBean<School> findAll(int pc, String datefrom, String dateto, String place) {
		String sql = "select * from outtuijian where Gtime>?  and Gtime<? and Gplace like ?  ORDER BY Gtime desc limit ?,?";
		String sql1 = "select count(*) from outtuijian where Gtime>? and Gtime<? and Gplace like ?";

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
			List<School> listSchool = (List) this.qr.query(sql, new BeanListHandler(School.class),
					new Object[] { datefrom, dateto, "%" + place + "%", Integer.valueOf((pc - 1) * this.ps),
							Integer.valueOf(this.ps) });
			PageBean<School> pb = new PageBean();

			pb.setBeanList(listSchool);
			pb.setPc(pc);
			pb.setPs(this.ps);
			pb.setTr(tr);
			pb.setPageCount(pageCount);
			pb.getPageCount();
			return pb;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public List<accountID> queryID() throws SQLException {
		String sql = "select ID from  outtuijian";
		List<accountID> id = (List) this.qr.query(sql, new BeanListHandler(accountID.class));
		return id;
	}

	public School findById(String gid) {
		String sql = "select * from outtuijian where id=?";
		try {
			return (School) this.qr.query(sql, new BeanHandler(School.class), gid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void editSchool(School school, String gid) {
		String sql = "update outtuijian set Gtheme=?,Gpart=? ,Gtime=? ,Gcontent=? ,Gusername=?,Gperson=?,Gplace=? ,Gtupian=? where id=?";
		Object[] params = { school.getGtheme(), school.getGpart(), school.getGtime(), school.getGcontent(),
				school.getGusername(), Integer.valueOf(school.getGperson()), school.getGplace(), school.getGtupian(),
				gid };
		try {
			this.qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void addTuiSchool(School school) {
		String sql = "insert into outtuijian(Gtheme,Gpart,Gtime,Gcontent,Gusername,Gperson,Gremain,Gtupian,Gprice,Gplace)values(?,?,?,?,?,?,?,?,?,?)";
		Object[] params = { school.getGtheme(), school.getGpart(), school.getGtime(), school.getGcontent(),
				school.getGusername(), Integer.valueOf(school.getGperson()), school.getGremain(), school.getGtupian(),
				school.getGprice(), school.getGplace() };
		try {
			this.qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public void delete(String gid) {
		String sql = "delete from outtuijian where id=?";
		try {
			this.qr.update(sql, gid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
