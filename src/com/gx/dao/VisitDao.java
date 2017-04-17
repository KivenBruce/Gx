package com.gx.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.gx.entity.Visit;

import cn.itcast.jdbc.TxQueryRunner;


public class VisitDao
{
  private QueryRunner qr = new TxQueryRunner();
  
  public List<Visit> selectMessageDaily(String dateFrom, String dateTo)
  {
    String sql = "SELECT GvisitTime,Gcount FROM visit WHERE visit.GvisitTime >=? AND visit.GvisitTime <= ? UNION(SELECT datelist,count FROM calendar WHERE datelist >= ?and datelist <= ? and datelist NOT IN (SELECT GvisitTime FROM visit WHERE visit.GvisitTime >=?AND visit.GvisitTime <= ?))order by GvisitTime asc";
    
    List<Visit> visitlist = null;
    try
    {
      visitlist = (List)this.qr.query(sql, new BeanListHandler(Visit.class), new Object[] { dateFrom, dateTo, dateFrom, dateTo, 
        dateFrom, dateTo });
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    return visitlist;
  }
  
  public void updateVisit(Date date)
  {
    String sql = "select * from visit where GvisitTime=?";
    try
    {
      Visit visit = (Visit)this.qr.query(sql, new BeanHandler(Visit.class), new Object[] { date });
      if (visit == null)
      {
        String sql1 = "insert into visit(Gcount,GvisitTime)values(1,?)";
        this.qr.update(sql1, date);
      }
      else
      {
        String sql2 = "update visit set Gcount=Gcount+1 where GvisitTime=?";
        this.qr.update(sql2, date);
      }
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
  }
  
  public List<Integer> selectDetail(Date date)
  {
    String sql = "select sum(Gcount) from visit ";
    String sql1 = "select Gcount from visit where GvisitTime=?";
    
    List<Integer> list = new ArrayList();
    try
    {
      Number allvisit = (Number)this.qr.query(sql, new ScalarHandler());
      int allv = allvisit.intValue();
      Number todayvisit = (Number)this.qr.query(sql1, new ScalarHandler(), new Object[] { date });
      int todayv = todayvisit.intValue();
      list.add(Integer.valueOf(allv));
      list.add(Integer.valueOf(todayv));
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    return list;
  }
}
