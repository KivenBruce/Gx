package com.gx.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.gx.dao.ClubDao;
import com.gx.dao.CommentDao;
import com.gx.dao.UserDao;
import com.gx.dao.VisitDao;
import com.gx.entity.Club;
import com.gx.entity.User;
import com.gx.entity.Visit;
import com.gx.pager.PageBean;
import com.gx.pager.PageConstants;
import com.gx.utils.DateUtils;
import com.gx.utils.JsonUtils;

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
	private ClubDao clubDao = new ClubDao();
	private CommentDao commentDao = new CommentDao();

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
		PageBean<Club> pb = (PageBean<Club>) clubDao.findByUserId(user.getId());
		int likecount = clubDao.findLikeCountById(user.getId());
		int commentCount = commentDao.getCommentCount(user.getId());
		List<Map<String, Object>> count = clubDao.findCount();
		Map<Object, Object> clubFocusCount = new HashMap<>();
		for (Map<String, Object> map : count) {
			clubFocusCount.put(map.get("club_id"), map.get("count"));
		}
		request.setAttribute("likecount", likecount);// 用户点赞总数
		request.setAttribute("commentCount", commentCount);// 用户评论总数
		request.setAttribute("clubFocusCount", clubFocusCount);// 返回每个club的关注量,后台遍历Map
		request.setAttribute("user", user);
		request.setAttribute("gid", user.getId());
		request.setAttribute("pb", pb);
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
		String defaultimg=request.getParameter("defaultimg");
		if(user.getGimage()==null||user.getGimage().equals("")){
			user.setGimage(defaultimg);
		}
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
	public void editAccount(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
		HttpSession session = request.getSession();
		String gid = request.getParameter("gid");
		String gimage = request.getParameter("gimage");
		String gusername = request.getParameter("gusername");
		String gmail = request.getParameter("gmail");
		String gtel = request.getParameter("gtel");
		String gtitle = request.getParameter("gtitle");
		User user = CommonUtils.toBean(request.getParameterMap(), User.class);
		String sessionlevel=session.getAttribute("level").toString();
		int level=Integer.parseInt(sessionlevel);
		user.setLevel(level);// 普通用户等级
		String info = "success";
		JSONObject jo = new JSONObject();
		User user1 = userDao.findById(gid);
		if (user.getGpwd() == null) {// 进入更新用户信息操作
			if (user.getGimage() == null || user.getGimage().equals("")) {// 未更换头像,使用原来的头像
				user.setGimage(user1.getGimage());
			}
			if (user.getGusername().equals(user1.getGusername())) {// 未对用户名进行修改.不修改用户名也算是修改,也可以修改其他的
				userDao.editUser(user, gid);
				log.debug("修改用户信息成功!");
			} else {// 已对用户名进行修改
				if (userDao.exist(user).equals("noexist")) {// 新用户名
					userDao.editUser(user, gid);
					log.debug("修改用户信息成功!");
					session.setAttribute("name", user.getGusername());
					info = "修改用户信息成功";
				} else {// 用户名已存在
					log.debug("该用户名已存在,修改用户信息失败!!!");
					info = "保存失败,该用户名已存在!";
				}
			}
		} else {// 进入更改密码操作
			if (user.getGpwd() != null && user.getGpwd().length() > 0) {
				String pwd = user.getGpwd();
				MessageDigest md5 = MessageDigest.getInstance("MD5");
				BASE64Encoder base64en = new BASE64Encoder();
				String passEncode = base64en.encode(md5.digest(pwd.getBytes("utf-8")));
				userDao.resetPass(gid, passEncode);
				session.setAttribute("pwd", pwd);
				log.debug("修改用户密码成功!");
				info = "修改用户密码成功";
			}

		}
		jo.put("userimage", user.getGimage());
		jo.put("info", info);
		response.getWriter().write(jo.toString());
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
		List<Visit> msgDaily = visitDao.selectMessageDaily(dateFrom, dateTo);// 时间期内每天访问量
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
			userDao.resetPass(gid, passEncode);
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