package com.gx.web.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;

import com.gx.user.dao.UserDao;

public class OnlineFilter implements Filter {
	private String excludedPages;
	private String[] excludedPageArray;

	public void init(FilterConfig fConfig) throws ServletException {
		this.excludedPages = fConfig.getInitParameter("excludedPages");
		if (StringUtils.isNotEmpty(this.excludedPages)) {
			this.excludedPageArray = this.excludedPages.split(",");
		}
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		boolean isExcludedPage = false;
		HttpServletResponse res = (HttpServletResponse) response;
		//HttpServletRequest req=(HttpServletRequest) request;
		//String pa=req.getRequestURI();
		// String path = ((HttpServletRequest) request).getServletPath();
		String path = ((HttpServletRequest) request).getRequestURL().toString();		
		String pp = null;
		int begin = path.lastIndexOf("/");
		if (begin != -1) {
			pp = path.substring(begin, path.length());
		} else {
			pp = path;
		}
		String[] arrayOfString;
		int j = (arrayOfString = this.excludedPageArray).length;
		for (int i = 0; i < j; i++) {
			String page = arrayOfString[i];
			if (pp.equals(page) || pp.contains("css") || (pp.contains("js")&&!pp.contains("jsp")) || pp.contains("png") || pp.contains("jpg")
					|| pp.contains("gif") || pp.contains("woff")|| pp.contains("video")||pp.contains("ico")) {
				isExcludedPage = true;
				break;
			}
		}
		if (isExcludedPage) {
			chain.doFilter(request, response);
		} else {
			HttpSession session = ((HttpServletRequest) request).getSession();
			String username = (String) (session.getAttribute("name"));
			if ((session == null) || username == null) {
				if(pp.equals("/")){
					request.getRequestDispatcher("/index.jsp").forward(request, response);	
				}else{
					request.getRequestDispatcher("/login.jsp").forward(request, response);
				}
				
				System.out.println("用户没有登录,不允许操作!");
				res.setHeader("Cache-Control", "no-store");
				res.setDateHeader("Expires", 0L);
				res.setHeader("Pragma", "no-cache");
			} else{
				chain.doFilter(request, response);
			}
				
		}
	}
}
