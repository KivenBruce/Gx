package com.gx.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class NoCacheFilter
  implements Filter
{
  public void destroy() {}
  
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
    throws IOException, ServletException
  {
    HttpServletResponse hsr = (HttpServletResponse)res;
    hsr.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    hsr.setHeader("Pragma", "no-cache");
    hsr.setDateHeader("Expires", 0L);
    chain.doFilter(req, res);
  }
  
  public void init(FilterConfig arg0)
    throws ServletException
  {}
}
