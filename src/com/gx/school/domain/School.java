
package com.gx.school.domain;

public class School
{
  private int id;
  private String Gtheme;
  private String Gpart;
  private String Gtime;
  private String Gcontent;
  private String Gusername;
  private int Gperson;
  private String Gprice;
  private String Gplace;
  private String Gtupian;
  private int Gflag;
  private int Gvisits;
  private String Gremain;
  
  public String getGtupian()
  {
    return this.Gtupian;
  }
  
  public int getId()
  {
    return this.id;
  }
  
  public void setId(int id)
  {
    this.id = id;
  }
  
  public void setGtupian(String gtupian)
  {
    this.Gtupian = gtupian;
  }
  
  public String getGtheme()
  {
    return this.Gtheme;
  }
  
  public void setGtheme(String gtheme)
  {
    this.Gtheme = gtheme;
  }
  
  public String getGpart()
  {
    return this.Gpart;
  }
  
  public void setGpart(String gpart)
  {
    this.Gpart = gpart;
  }
  
  public String getGtime()
  {
    return this.Gtime;
  }
  
  public void setGtime(String gtime)
  {
    this.Gtime = gtime;
  }
  
  public String getGcontent()
  {
    return this.Gcontent;
  }
  
  public void setGcontent(String gcontent)
  {
    this.Gcontent = gcontent;
  }
  
  public String getGusername()
  {
    return this.Gusername;
  }
  
  public void setGusername(String gusername)
  {
    this.Gusername = gusername;
  }
  
  public int getGperson()
  {
    return this.Gperson;
  }
  
  public void setGperson(int gperson)
  {
    this.Gperson = gperson;
  }
  
  public String getGprice()
  {
    return this.Gprice;
  }
  
  public void setGprice(String gprice)
  {
    this.Gprice = gprice;
  }
  
  public String getGplace()
  {
    return this.Gplace;
  }
  
  public void setGplace(String gplace)
  {
    this.Gplace = gplace;
  }
  
  public int getGflag()
  {
    return this.Gflag;
  }
  
  public void setGflag(int gflag)
  {
    this.Gflag = gflag;
  }
  
  public int getGvisits()
  {
    return this.Gvisits;
  }
  
  public void setGvisits(int gvisits)
  {
    this.Gvisits = gvisits;
  }
  
  public String getGremain()
  {
    return this.Gremain;
  }
  
  public void setGremain(String gremain)
  {
    this.Gremain = gremain;
  }
  
  public School(int id, String gtheme, String gpart, String gtime, String gcontent, String gusername, int gperson, String gprice, String gplace, String gtupian, int gflag, int gvisits, String gremain)
  {
    this.id = id;
    this.Gtheme = gtheme;
    this.Gpart = gpart;
    this.Gtime = gtime;
    this.Gcontent = gcontent;
    this.Gusername = gusername;
    this.Gperson = gperson;
    this.Gprice = gprice;
    this.Gplace = gplace;
    this.Gtupian = gtupian;
    this.Gflag = gflag;
    this.Gvisits = gvisits;
    this.Gremain = gremain;
  }
  
  public School() {}
}
