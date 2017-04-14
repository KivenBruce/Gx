package com.gx.tui.servlet;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.gx.pager.PageBean;
import com.gx.school.domain.School;
import com.gx.tui.dao.InDao;

/**
 * 校内推荐活动增删改查
 * @author Administrator
 *
 */
public class InServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	Logger log=Logger.getLogger(this.getClass());
	private InDao ns = new InDao();

	/**
	 * 保存修改
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException 
	 */
	public String editSchool(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String gid = request.getParameter("gid");
		School school = (School) CommonUtils.toBean(request.getParameterMap(), School.class);
		String tupian = request.getParameter("tupian");
		String gtupian = request.getParameter("gtupian");
		if (tupian != null) {
			if (tupian.equals("")) {
				school.setGtupian(gtupian);
			} else {
				school.setGtupian(tupian);
			}
			school.setGcontent(school.getGcontent().trim());
			this.ns.editSchool(school, gid);
			log.debug("修改校内推荐活动成功!");
			return findAll(request, response);
		} else {
			request.setAttribute("msg", "修改页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

	/**
	 * findAll进入编辑
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String reload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String gid = request.getParameter("gid");
		School School = this.ns.findById(gid);
		request.setAttribute("school", School);
		request.setAttribute("gid", gid);
		request.setAttribute("type", "inschool");
		return "f:/adminjsps/edittuischool.jsp";
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String gid = request.getParameter("gid");
		this.ns.delete(gid);
		log.debug("删除校内推荐活动成功!");
		return findAll(request, response);
	}

	/**
	 * 增加推荐活动
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException 
	 */
	public String addTuiSchool(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		School school = (School) CommonUtils.toBean(request.getParameterMap(), School.class);
		String gtupian = request.getParameter("gtupian");
		if (gtupian != null) {
			school.setGcontent(school.getGcontent().trim());
			this.ns.addTuiSchool(school);
			log.debug("增加校内推荐活动成功!");
			return findAll(request, response);
		} else {
			request.setAttribute("msg", "新增页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

	/**
	 * 查找所有的校内推荐活动
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
		String datefrom = request.getParameter("datefrom");
		String dateto = request.getParameter("dateto");
		String place = request.getParameter("place");
		if (place != null) {
			place = URLDecoder.decode(place, "utf8");
		}
		int curPage = getPc(request);
		if (curPage <= 1) {
			curPage = 1;
		}
		PageBean<School> pb = this.ns.findAll(curPage, datefrom, dateto, place);
		if (curPage >= pb.getPageCount()) {
			curPage = pb.getPageCount();
		}
		request.setAttribute("msg", "校内推荐活动");
		request.setAttribute("pb", pb);
		request.setAttribute("curPage", Integer.valueOf(curPage));
		request.setAttribute("datefrom", datefrom);
		request.setAttribute("dateto", dateto);
		request.setAttribute("place", place);
		request.setAttribute("type", "inschool");
		return "f:/adminjsps/tuischool.jsp";
	}

	private int getPc(HttpServletRequest req) {
		int pc = 1;
		String param = req.getParameter("curPage");
		if ((param != null) && (!param.trim().isEmpty())) {
			try {
				pc = Integer.parseInt(param);
			} catch (RuntimeException localRuntimeException) {
			}
		}
		return pc;
	}

}
