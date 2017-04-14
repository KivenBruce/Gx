package com.gx.school.dao;

import cn.itcast.jdbc.TxQueryRunner;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.log4j.Logger;

import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;
import com.gx.school.domain.School;

public class OutschoolDao
{
  private static final Logger logger = Logger.getLogger(OutschoolDao.class);
  private QueryRunner qr = new TxQueryRunner();
  
  public PageBean<School> findAll(int pc, String datefrom, String dateto, String place)
  {
	int ps = PageConstants.BOOK_PAGE_SIZE;// 每页记录数;
    String sql = "select * from outschool where Gtime>?  and Gtime<? and Gplace like ?  ORDER BY Gtime desc limit ?,?";
    String sql1 = "select count(*) from outschool where Gtime>? and Gtime<? and Gplace like ?";
    Number number = null;
    try
    {
      if (datefrom == null)
      {
        datefrom = "0";
        dateto = "default";
        place = "";
      }
      else if (datefrom.length() == 0)
      {
        if (dateto.length() == 0)
        {
          if (place.length() == 0)
          {
            datefrom = "0";
            dateto = "default";
            place = "";
          }
          else
          {
            datefrom = "0";
            dateto = "default";
          }
        }
        else if (place.length() == 0)
        {
          datefrom = "0";
          place = "";
        }
        else
        {
          datefrom = "0";
        }
      }
      else if (dateto.length() == 0)
      {
        if (place.length() == 0)
        {
          dateto = "default";
          place = "";
        }
        else
        {
          dateto = "default";
        }
      }
      else if (place.length() == 0)
      {
        place = "";
      }
      number = (Number)this.qr.query(sql1, new ScalarHandler(), new Object[] { datefrom, dateto, "%" + place + "%" });
      int tr = number.intValue();
      logger.debug("校外活动总记录条数 " + tr);
      int pageCount = tr % ps == 0 ? tr / ps : tr / ps + 1;
      if (pc >= pageCount) {
        pc = pageCount;
      }
      List<School> listSchool = (List)this.qr.query(sql, new BeanListHandler(School.class), new Object[] { datefrom, dateto, "%" + place + "%", Integer.valueOf((pc - 1) * ps), Integer.valueOf(ps) });
      PageBean<School> pb = new PageBean();
      
      pb.setBeanList(listSchool);
      pb.setPc(pc);
      pb.setPs(ps);
      pb.setTr(tr);
      pb.setPageCount(pageCount);
      pb.getPageCount();
      return pb;
    }
    catch (SQLException e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public School findById(String gid)
  {
    String sql = "select * from outschool where id=?";
    try
    {
      return (School)this.qr.query(sql, new BeanHandler(School.class), new Object[] { gid });
    }
    catch (SQLException e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public List<accountID> queryID()
    throws SQLException
  {
    String sql = "select ID from  outschool";
    List<accountID> id = (List)this.qr.query(sql, new BeanListHandler(accountID.class));
    return id;
  }
  
  public void addSchool(School school)
  {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date date = new Date();
    String format = sdf.format(date);
    String sql = "insert into outschool(Gtheme,Gpart,Gtime,Gcontent,Gusername,Gperson,Gremain,Gtupian,Gprice,Gplace)values(?,?,?,?,?,?,?,?,?,?)";
    Object[] params = { school.getGtheme(), school.getGpart(), 
      school.getGtime().length() == 0 ? format : school.getGtime(), school.getGcontent(), 
      school.getGusername(), Integer.valueOf(school.getGperson()),school.getGremain(), school.getGtupian(), school.getGprice(), 
      school.getGplace() };
    try
    {
      this.qr.update(sql, params);
    }
    catch (SQLException e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public void delete(String gid)
  {
    String sql = "delete from outschool where id=?";
    try
    {
      System.out.println(gid);
      this.qr.update(sql, gid);
    }
    catch (SQLException e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public void editSchool(School school, String gid)
  {
    String sql = "update outschool set Gtheme=? ,Gpart=? ,Gremain=? ,Gpart=? ,Gtime=? ,Gcontent=? ,Gusername=?,Gperson=?,Gtupian=?,Gprice=?,Gplace=? where ID=" + 
      gid;
    Object[] params = { school.getGtheme(),school.getGpart(),school.getGremain(),school.getGpart(), school.getGtime(), school.getGcontent(), school.getGusername(), 
      Integer.valueOf(school.getGperson()), school.getGtupian(), school.getGprice(), school.getGplace() };
    try
    {
      this.qr.update(sql, params);
    }
    catch (SQLException e)
    {
      throw new RuntimeException(e);
    }
  }
}
