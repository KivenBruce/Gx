package com.gx.school.servlet;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import com.gx.pager.PageBean;
import com.gx.school.dao.OutschoolDao;
import com.gx.school.domain.School;

/**
 * 校外活动增删改查
 * @author Administrator
 *
 */
public class OutschoolServlet extends BaseServlet {
	private OutschoolDao ns = new OutschoolDao();
	private static final Logger log = Logger.getLogger(OutschoolDao.class);

	/**
	 * 修改校外活动
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
		School school;
		String gid = request.getParameter("gid");
		school = (School) CommonUtils.toBean(request.getParameterMap(), School.class);
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
			log.debug("修改校外活动成功!");
			return findAll(request, response);
		} else {
			request.setAttribute("msg", "修改页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

	public String reload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String gid = request.getParameter("gid");
		School School = this.ns.findById(gid);
		request.setAttribute("school", School);
		request.setAttribute("gid", gid);
		request.setAttribute("type", "outschool");
		return "f:/adminjsps/editschool.jsp";
	}

	/**
	 * 删除校外活动
	 * 
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
		log.debug("删除校外推荐活动成功!");
		return findAll(request, response);
	}

	/**
	 * 新增校外活动
	 * 
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
			log.debug("新增校外推荐活动成功!");
			return findAll(request, response);
		} else {
			request.setAttribute("msg", "新增页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int curPage = getPc(request);
		String datefrom = request.getParameter("datefrom");
		String dateto = request.getParameter("dateto");
		String place = request.getParameter("place");
		if (place != null) {
			place = URLDecoder.decode(place, "utf8");
		}
		if (curPage <= 1) {
			curPage = 1;
		}
		PageBean<School> pb = this.ns.findAll(curPage, datefrom, dateto, place);
		if (curPage >= pb.getPageCount()) {
			curPage = pb.getPageCount();
		}
		request.setAttribute("msg", "校外活动");
		request.setAttribute("pb", pb);
		request.setAttribute("curPage", Integer.valueOf(curPage));
		request.setAttribute("datefrom", datefrom);
		request.setAttribute("dateto", dateto);
		request.setAttribute("place", place);
		request.setAttribute("type", "outschool");
		return "f:/adminjsps/school.jsp";
	}

	public String findById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String gtheme = request.getParameter("gtheme");
		School School = this.ns.findById(gtheme);
		request.setAttribute("School", School);
		return "f:/jsps/pingtai/Schoolcon.jsp";
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
