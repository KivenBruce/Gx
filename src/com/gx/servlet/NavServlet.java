package com.gx.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.gx.dao.NavDao;
import com.gx.entity.Navigate;
import com.gx.pager.PageBean;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class NavServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	Logger log = Logger.getLogger(this.getClass());
	private NavDao nd = new NavDao();

	/**
	 * 查找所有的导航活动
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String type = request.getParameter("type");
		PageBean<Navigate> navlist = nd.findAll(type);
		request.setAttribute("navlist", navlist);
		request.setAttribute("type", type);
		return "f:/adminjsps/navlist.jsp";

	}

	/**
	 * 进入编辑导航页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public String reload(HttpServletRequest request, HttpServletResponse response) {
		String gid = request.getParameter("gid");
		String type = request.getParameter("type");
		Navigate navigate = nd.findById(gid, type);
		request.setAttribute("nav", navigate);
		request.setAttribute("gid", gid);
		request.setAttribute("type", type);
		return "f:/adminjsps/editnav.jsp";

	};

	/**
	 * 修改导航操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ServletException
	 */
	public String editNav(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String gid = request.getParameter("gid");
		String type = request.getParameter("type");
		int radio = Integer.parseInt(request.getParameter("aa"));

		Navigate navigate = (Navigate) CommonUtils.toBean(request.getParameterMap(), Navigate.class);
		if(navigate.getGurl()==null){
			navigate.setGurl("0");
		}else{
			navigate.setGurl("http://"+navigate.getGurl());
		}
		String tupian = request.getParameter("tupian");
		String gtupian = request.getParameter("gtupian");
		if (tupian != null) {
			if (tupian.equals("")) {
				navigate.setGtupian(gtupian);
			} else {
				navigate.setGtupian(tupian);
			}
			navigate.setGadv(radio);
			navigate.setGcontent(navigate.getGcontent().trim());
			nd.editNavigate(navigate, gid, type);
			log.debug("修改校内导航成功!");
			return findAll(request, response);
		} else {
			request.setAttribute("msg", "导航修改页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

}
