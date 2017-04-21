package com.gx.servlet;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import com.gx.dao.ClubDao;
import com.gx.dao.CommentDao;
import com.gx.dao.UserDao;
import com.gx.entity.Club;
import com.gx.entity.Comment;
import com.gx.entity.User;
import com.gx.pager.ClubConstants;
import com.gx.pager.PageBean;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class ClubServlet extends BaseServlet {

	/**
	 * hzx 2017/4/10
	 */
	private static final long serialVersionUID = 1L;
	Logger log = Logger.getLogger(ClubServlet.class);
	private ClubDao clubDao = new ClubDao();
	private UserDao userDao = new UserDao();
	CommentDao commentDao = new CommentDao();

	/**
	 * 查找所有的club
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
		String urlparentid = request.getParameter("parentid");
		String question = request.getParameter("question");

		int parentid;
		boolean flag;
		if (urlparentid != null) {
			parentid = Integer.parseInt(urlparentid);
			flag = true;
		} else {
			parentid = 1234;
			flag = false;
		}
		HttpSession session = request.getSession();
		User user = userDao.findByName(session.getAttribute("name").toString());
		session.setAttribute("userid", user.getId());
		PageBean<Club> pb = (PageBean<Club>) clubDao.findAll(flag, parentid, user.getId(), question);
		PageBean<Club> hotpb = (PageBean<Club>) clubDao.findHot();// 查询热点club
		List<Map<String, Object>> count = clubDao.findCount();// 查询每个club的关注数量
		Map<Object, Object> mapcount = new HashMap<>();
		for (Map<String, Object> map : count) {
			mapcount.put(map.get("club_id"), map.get("count"));
		}
		List<Object[]> focusidList = clubDao.searchFocus(user.getId());
		String flist = new String();// 查询是否已关注club_id.其实不用这样做,jsp遍历focusidList就行.
		for (Object[] objects : focusidList) {
			for (Object object : objects) {
				flist = flist + object;// 查询所有关注的
			}
		}
		Number focusNum = focusidList.size();
		request.setAttribute("pb", pb);
		request.setAttribute("hotpb", hotpb);
		request.setAttribute("mapcount", mapcount);
		request.setAttribute("focusNum", focusNum);
		request.setAttribute("flist", flist);
		request.setAttribute("userid", user.getId());
		return "f:/club.jsp";
	}

	/**
	 * 点击查看club详情
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 * @throws ServletException
	 */
	public String clubDetail(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		String clubid = request.getParameter("clubid");
		String page = request.getParameter("curPage");
		HttpSession session = request.getSession();
		User user = userDao.findByName(session.getAttribute("name").toString());
		session.setAttribute("userid", user.getId());
		if (page == null) {
			page = "1";
		}
		int curPage = Integer.parseInt(page);
		if (curPage <= 1) {
			curPage = 1;
		}

		Number clubCount = clubDao.searchCountById(clubid);// 查找该club的关注总量
		if (clubCount == null) {
			clubCount = 0;
		}
		Club club = clubDao.selectInfoByCId(clubid, user.getId());// 查找club的详细资料.如果用户没关注这结果为空

		PageBean<Comment> commentList = commentDao.getCommentList(clubid, curPage);
		List<Comment> beanList = commentList.getBeanList();
		List<Integer> likeList = new ArrayList<Integer>();

		for (Comment comment : beanList) {
			int likeflag = clubDao.selectIsLike(comment.getId(), user.getId());// 根据commentid与userid判断是否已经点赞
			likeList.add(likeflag);
		}
		request.setAttribute("likeList", likeList);
		request.setAttribute("club", club);
		request.setAttribute("clubCount", clubCount);
		request.setAttribute("commentList", commentList);
		request.setAttribute("curPage", commentList.getPageCount());
		request.setAttribute("clubid", clubid);
		request.setAttribute("userid", user.getId());
		return "f:/clubDetail.jsp";
	}

	/**
	 * 用户点击关注与取消关注 返回该用户所有关注的club数量,以及显示每个club被关注的数量.
	 * 
	 * @param request
	 * @param response
	 * @throws SQLException
	 * @throws IOException
	 */
	public void focus(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		int value = Integer.parseInt(request.getParameter("value"));// 是否关注标识
		String clubid = request.getParameter("clubid");// clubid
		String userid = request.getParameter("userid");// 用户id
		Club club = clubDao.selectInfoByCId(clubid, Integer.parseInt(userid));
		clubDao.changeFocus(value, club, userid);
		JSONObject jo = new JSONObject();
		Number focusNum = clubDao.searchFocus(Integer.parseInt(userid)).size();
		Number clubCount = clubDao.searchCountById(clubid);// 查找每个club的关注总量
		if (clubCount == null) {
			clubCount = 0;
		}
		jo.put("userclubcount", focusNum);// 返回更改后的标识
		jo.put("clubCount", clubCount);
		System.out.println(jo.toString());
		response.getWriter().write(jo.toString());
	}

	/**
	 * 根据评论id删除评论
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 * @throws ServletException
	 * @throws IOException
	 */
	public void deleteComment(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		String commentid = request.getParameter("commentid");
		commentDao.deleteComment(commentid);
		JSONObject jo = new JSONObject();
		jo.put("result", "delete success");
		response.getWriter().write(jo.toString());
	}

	/**
	 * 点赞数量更新
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	public void updateLikeCount(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String commentid = request.getParameter("commentid");
		String likecount = request.getParameter("likecount");
		String flag = request.getParameter("flag");
		int userid = (int) request.getSession().getAttribute("userid");
		int count = Integer.parseInt(likecount);
		commentDao.updateLikeCount(commentid, count, flag, userid);
		JSONObject jo = new JSONObject();
		jo.put("likecount", "123");
		response.getWriter().write(jo.toString());
	}

	public String addComment(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		Comment comment = CommonUtils.toBean(request.getParameterMap(), Comment.class);
		if (comment.getContent() != null) {
			commentDao.addComment(comment);
		}

		return clubDetail(request, response);
	}

	
	/**
	 * 处理图片方法
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void doImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/octet-stream;charset=UTF-8");
		String file = request.getParameter("filepath");
		String parent_id = request.getParameter("parentid");
		int parentid;
		String target = null;
		if (parent_id != null) {
			parentid = Integer.parseInt(request.getParameter("parentid"));

			if (parentid == ClubConstants.GAME_ID) {
				target = ClubConstants.GAME_PATH + file;
			} else if (parentid == ClubConstants.INTERNET_ID) {
				target = ClubConstants.INTERNET_PATH + file;
			} else if (parentid == ClubConstants.SPORT_ID) {
				target = ClubConstants.SPORT_PATH + file;
			}
		} else {
			target = ClubConstants.USER_IMG_PATH + file;
		}
		if (!file.isEmpty()) {

			FileInputStream in = new FileInputStream(target);
			try {
				int i = in.available();
				byte[] data = new byte[i];
				in.read(data);
				in.close();

				OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
				outputStream.write(data);
				outputStream.flush();
				outputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			this.log.error("图片不存在!");
		}
	}
	
}
