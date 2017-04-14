package com.gx.school.servlet;

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
import com.gx.school.dao.InschoolDao;
import com.gx.school.domain.School;

/**
 * 校内活动增删改成
 * @author Administrator
 *
 */
public class InschoolServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private InschoolDao ns = new InschoolDao();
	Logger log = Logger.getLogger(InschoolServlet.class);

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
			log.debug("修改校内活动成功!");
			return findAll(request, response);
		} else {
			request.setAttribute("msg", "修改页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

	/**
	 * 进入编辑
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String reload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String gid = request.getParameter("gid");
		School School = this.ns.findById(gid);
		request.setAttribute("school", School);
		request.setAttribute("gid", gid);
		request.setAttribute("type", "inschool");
		return "f:/adminjsps/editschool.jsp";
	}

	/**
	 * 删除活动
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String gid = request.getParameter("gid");
		this.ns.delete(gid);
		log.debug("删除校内活动成功!");
		return findAll(request, response);
	}

	/**
	 * 增加活动
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException 
	 */
	public String addSchool(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		School School = (School) CommonUtils.toBean(request.getParameterMap(), School.class);
		String gtupian = request.getParameter("gtupian");
		if (gtupian != null) {
			School.setGcontent(School.getGcontent().trim());
			this.ns.addSchool(School);
			log.debug("新增校内推荐活动成功!");
			return findAll(request, response);
		} else {
			request.setAttribute("msg", "新增页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

	/**
	 * 管理员查询活动
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
		request.setAttribute("msg", "校内活动");
		request.setAttribute("pb", pb);
		request.setAttribute("curPage", Integer.valueOf(curPage));
		request.setAttribute("datefrom", datefrom);
		request.setAttribute("dateto", dateto);
		request.setAttribute("place", place);
		request.setAttribute("type", "inschool");
		//request.getRequestDispatcher("/WEB-INF/bai/main.jsp").forward(request, response);
		return "f:/adminjsps/school.jsp";
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
