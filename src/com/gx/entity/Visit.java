package com.gx.entity;

import java.util.Date;

public class Visit
{
  private int id;
  private int Gcount;
  private Date GvisitTime;
  
  public int getId()
  {
    return this.id;
  }
  
  public void setId(int id)
  {
    this.id = id;
  }
  
  public int getGcount()
  {
    return this.Gcount;
  }
  
  public void setGcount(int gcount)
  {
    this.Gcount = gcount;
  }
  
  public Date getGvisitTime()
  {
    return this.GvisitTime;
  }
  
  public void setGvisitTime(Date gvisitTime)
  {
    this.GvisitTime = gvisitTime;
  }
  
  public String toString()
  {
    return "Visit [id=" + this.id + ", Gcount=" + this.Gcount + ", GvisitTime=" + this.GvisitTime + "]";
  }
  
  public Visit(int id, int gcount, Date gvisitTime)
  {
    this.id = id;
    this.Gcount = gcount;
    this.GvisitTime = gvisitTime;
  }
  
  public Visit() {}
}
