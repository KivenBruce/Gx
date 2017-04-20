package com.gx.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.gx.entity.Navigate;
import com.gx.pager.PageBean;

import cn.itcast.jdbc.TxQueryRunner;

public class NavDao {
	private QueryRunner qr = new TxQueryRunner();
	public PageBean<Navigate> findAll(String type) throws SQLException {	
		String sql="select  * from nav_active where gflag="+type+" order by Gtime desc limit 4";
		List<Navigate> listnav = (List<Navigate>) qr.query(sql, new BeanListHandler(Navigate.class));
		PageBean<Navigate> pb = new PageBean();
		pb.setBeanList(listnav);
		return pb;
	}
	public Navigate findById(String gid,String type) {
		String sql = "select * from nav_active where gflag="+type+" and id=?";
		try {
			return (Navigate) qr.query(sql, new BeanHandler(Navigate.class), gid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public void editNavigate(Navigate navigate, String gid,String type) {
		String sql = "update nav_active set Gtheme=?,Gpart=? ,Gtime=? ,Gcontent=? ,Gusername=?,Gperson=?,Gplace=? ,Gtupian=?,Gurl=?,Gadv=? where id=?";
		Object[] params = { navigate.getGtheme(), navigate.getGpart(), navigate.getGtime(), navigate.getGcontent(),
				navigate.getGusername(), Integer.valueOf(navigate.getGperson()), navigate.getGplace(), navigate.getGtupian(),navigate.getGurl(),navigate.getGadv(),
				gid };
		try {
			this.qr.update(sql, params);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}		
}
