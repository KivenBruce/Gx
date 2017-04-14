package com.gx.pager;

import java.util.List;

public class PageBean<T>
{
  private int pc;
  private int tr;
  private int ps;
  private String url;
  private List<T> beanList;
  private int pageCount;
  
  public int getPageCount()
  {
    return this.pageCount;
  }
  
  public void setPageCount(int pageCount)
  {
    this.pageCount = pageCount;
  }
  
  public int getTp()
  {
    int tp = this.tr / this.ps;
    return this.tr % this.ps == 0 ? tp : tp + 1;
  }
  
  public int getPc()
  {
    return this.pc;
  }
  
  public void setPc(int pc)
  {
    this.pc = pc;
  }
  
  public int getTr()
  {
    return this.tr;
  }
  
  public void setTr(int tr)
  {
    this.tr = tr;
  }
  
  public int getPs()
  {
    return this.ps;
  }
  
  public void setPs(int ps)
  {
    this.ps = ps;
  }
  
  public String getUrl()
  {
    return this.url;
  }
  
  public void setUrl(String url)
  {
    this.url = url;
  }
  
  public List<T> getBeanList()
  {
    return this.beanList;
  }
  
  public void setBeanList(List<T> beanList)
  {
    this.beanList = beanList;
  }
}
