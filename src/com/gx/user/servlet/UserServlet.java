package com.gx.user.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;
import com.gx.school.domain.School;
import com.gx.user.dao.UserDao;
import com.gx.user.domain.User;
import com.gx.visit.dao.VisitDao;
import com.gx.visit.domain.Visit;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;
import sun.misc.BASE64Encoder;

public class UserServlet extends BaseServlet {

	/**
	 * hzx 2016/10/28
	 */
	private static final long serialVersionUID = 1L;
	Logger log = Logger.getLogger(this.getClass());
	private UserDao userDao = new UserDao();
	private VisitDao visitDao = new VisitDao();

	/**
	 * 进入管理员修改编辑
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
		User user = userDao.findById(gid);
		request.setAttribute("user", user);
		request.setAttribute("gid", gid);
		return "f:/adminjsps/edituser.jsp";
	}

	/**
	 * 用户级别管理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String level(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String username = request.getParameter("gusername");
		String level = request.getParameter("level");
		String levelbefore = request.getParameter("levelbofore");
		int lev = Integer.parseInt(level);
		int levb = Integer.parseInt(levelbefore);
		userDao.level(username, lev, levb);
		log.debug("级别管理操作成功");
		return findAll(request, response);
	}

	/**
	 * 查找所有的用户
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
		int curPage = getPc(request);
		String username = request.getParameter("username");
		String userlevel = request.getParameter("userlevel");
		if (curPage <= 1) {
			curPage = 1;
		}
		PageBean<User> pb = (PageBean<User>) userDao.findAll(curPage, username, userlevel);
		if (curPage >= pb.getPageCount()) {
			curPage = pb.getPageCount();
		}
		request.setAttribute("pb", pb);
		request.setAttribute("curPage", curPage);
		request.setAttribute("username", username);
		request.setAttribute("userlevel", userlevel);
		return "f:/adminjsps/roles.jsp";
	}

	/**
	 * 增加用户操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String addUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {// 增加新用户,得到的数据,其中涉及到radio,select的不正常.
		User user = CommonUtils.toBean(request.getParameterMap(), User.class);
		String gusername = request.getParameter("gusername");
		if (gusername != null) {
			String result = userDao.addUser(user);
			if (result == "noexist") {
				log.debug("添加新用户成功");
				return findAll(request, response);
			} else {
				request.setAttribute("msg", "isexist");
				return "f:/adminjsps/adduser.jsp";
			}
		} else {
			request.setAttribute("msg", "新增用户页面");
			return "f:/adminjsps/noedit.jsp";
		}

	}

	/**
	 * 进入普通用户修改编辑
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String reloadAccount(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("name");
		User user = userDao.findByName(username);
		request.setAttribute("user", user);
		request.setAttribute("gid", user.getId());
		return "f:/adminjsps/account.jsp";
	}

	/**
	 * 修改管理员账号用户信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 */
	public String editUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String gid = request.getParameter("gid");
		User user = CommonUtils.toBean(request.getParameterMap(), User.class);
		String username = request.getParameter("gusername");
		User user1 = userDao.findById(gid);
		if (username != null) {
			if (user.getGusername().equals(user1.getGusername())) {// 未对用户名进行修改
				userDao.editUser(user, gid);
				log.debug("修改用户成功!");
				return findAll(request, response);
			} else {// 已对用户名进行修改
				if (userDao.exist(user).equals("noexist")) {
					userDao.editUser(user, gid);
					log.debug("修改用户成功!");
					return findAll(request, response);
				} else {
					request.setAttribute("msg", "isexist");
					request.setAttribute("user", user);
					return "f:/adminjsps/edituser.jsp";
				}
			}

		} else {
			request.setAttribute("msg", "修改用户页面");
			return "f:/adminjsps/noedit.jsp";
		}
	}

	/**
	 * 修改普通用户账号信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws NoSuchAlgorithmException
	 */
	public String editAccount(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
		String gid = request.getParameter("gid");
		User user = CommonUtils.toBean(request.getParameterMap(), User.class);
		String username = request.getParameter("gusername");
		User user1 = userDao.findById(gid);
		HttpSession session = request.getSession();
		if (user.getLevel() == 0) {
			user.setLevel(3);
		}
		if (username != null) {
			if (user.getGusername().equals(user1.getGusername())) {// 未对用户名进行修改.不修改用户名也算是修改,也可以修改其他的
				userDao.editUser(user, gid);
				if (user.getGpwd() != null && user.getGpwd().length() > 0) {
					String pwd = user.getGpwd();
					MessageDigest md5 = MessageDigest.getInstance("MD5");
					BASE64Encoder base64en = new BASE64Encoder();
					String passEncode = base64en.encode(md5.digest(pwd.getBytes("utf-8")));
					userDao.resetPass(user, passEncode);
					session.setAttribute("pwd", pwd);
					log.debug("修改用户密码成功!");
				}
				log.debug("修改用户成功!");
				request.setAttribute("succflag", "1");
				request.setAttribute("user", user);
				request.setAttribute("gid", gid);
				return "f:/adminjsps/account.jsp";
			} else {// 已对用户名进行修改
				if (userDao.exist(user).equals("noexist")) {
					userDao.editUser(user, gid);
					if (user.getGpwd() != null && user.getGpwd().length() > 0) {
						String pwd = user.getGpwd();
						MessageDigest md5 = MessageDigest.getInstance("MD5");
						BASE64Encoder base64en = new BASE64Encoder();
						String passEncode = base64en.encode(md5.digest(pwd.getBytes("utf-8")));
						userDao.resetPass(user, passEncode);
						session.setAttribute("pwd", pwd);
						log.debug("修改用户密码成功!");
					}
					log.debug("修改用户成功!");
					request.setAttribute("succflag", "1");
					request.setAttribute("user", user);
					request.setAttribute("gid", gid);
					return "f:/adminjsps/account.jsp";
				} else {
					request.setAttribute("msg", "isexist");
					request.setAttribute("user", user);
					return "f:/adminjsps/account.jsp";
				}
			}

		} else {
			return "f:/adminjsps/account.jsp";
		}
	}

	/**
	 * 删除用户
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 */
	public String deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String gid = request.getParameter("gid");
		userDao.delete(gid);
		log.debug("删除用户成功!");
		return findAll(request, response);
	}

	/**
	 * 用户访问量数据查询
	 * 
	 * @param request
	 * @param response
	 */
	public void visitData(HttpServletRequest request, HttpServletResponse response) {
		String dateFrom = request.getParameter("datefrom");
		String dateTo = request.getParameter("dateto");
		List<Visit> msgDaily = visitDao.selectMessageDaily(dateFrom, dateTo);//时间期内每天访问量
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> categories = new ArrayList<String>();
		List<Integer> msgDailyList = new ArrayList<Integer>();
		if (msgDaily != null && !msgDaily.isEmpty()) {
			msgDaily.stream().forEach(a -> {
				categories.add(DateUtils.dateToString(a.getGvisitTime(), "yyyy/MM/dd"));
				msgDailyList.add(a.getGcount());
			});
			map.put("nodata", "");
		} else {
			map.put("nodata", "该时间段内无数据");
		}
		map.put("categories", categories);
		map.put("msgDaily", msgDailyList);
		String reJson = JsonUtils.MapToJson(map);
		response.setContentType("text/plain");
		response.setCharacterEncoding("utf-8");
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print(reJson);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 重置密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws NoSuchAlgorithmException
	 * @throws SQLException
	 */
	public String resetPass(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, NoSuchAlgorithmException, SQLException {// reset
		// password
		User user = CommonUtils.toBean(request.getParameterMap(), User.class);
		HttpSession session = request.getSession();
		String gid = request.getParameter("gid");
		if (user.getGpwd() != null) {
			String pwd = user.getGpwd();
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			BASE64Encoder base64en = new BASE64Encoder();
			String passEncode = base64en.encode(md5.digest(pwd.getBytes("utf-8")));
			userDao.resetPass(user, passEncode);
			session.setAttribute("pwd", pwd);
			log.debug("修改用户密码成功!");
		} else {
			userDao.resetPass(gid);
			session.setAttribute("pwd", PageConstants.INITAL_PASSWORD);
			log.debug("重置用户密码成功!");
		}

		return findAll(request, response);

	}

	private int getPc(HttpServletRequest req) {
		int pc = 1;
		String param = req.getParameter("curPage");
		if (param != null && !param.trim().isEmpty()) {
			try {
				pc = Integer.parseInt(param);
			} catch (RuntimeException e) {
			}
		}
		return pc;
	}
}
