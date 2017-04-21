package com.gx.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
import com.gx.dao.VisitDao;
import com.gx.entity.Club;
import com.gx.entity.User;
import com.gx.entity.Visit;
import com.gx.pager.ClubConstants;
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
		Map<String,String> map = copyImage(request, ClubConstants.USER_IMG_PATH);
		User user=new User(map.get("gusername"),map.get("gmail"), map.get("gtel"),map.get("gsex"), Integer.parseInt(map.get("level")), map.get("gimage"), map.get("gtitle"));
		if (map.size()>0) {
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

		Map<String,String> map = copyImage(request, ClubConstants.USER_IMG_PATH);

		String gid = request.getParameter("gid");	
		if (map.get("gimage")== null || map.get("gimage").equals("")) {
			map.put("gimage", map.get("defaultimg"));
		}
		User user=new User(map.get("gusername"),map.get("gmail"), map.get("gtel"),map.get("gsex"), Integer.parseInt(map.get("level")), map.get("gimage"), map.get("gtitle"));
		String username = (String) map.get("gusername");
		User user1 = userDao.findById(gid);
		if (username != null) {
			if (map.get("gusername").equals(user1.getGusername())) {// 未对用户名进行修改
				userDao.editUser(user, gid);
				log.debug("修改用户成功!");
				return findAll(request, response);
			} else {// 已对用户名进行修改
				if (userDao.exist(user).equals("noexist")) {//新用户名
					userDao.editUser(user, gid);
					log.debug("修改用户成功!");
					
				} else {
					request.setAttribute("msg", "该用户名已存在!");
					request.setAttribute("user", user);
					request.setAttribute("gid", gid);
					return "f:/adminjsps/edituser.jsp";
				}
				return findAll(request, response);
			}

		} else {
			request.setAttribute("msg", "修改用户页面");
			return "f:/adminjsps/noedit.jsp";
		}
	}

	private Map copyImage(HttpServletRequest request, String targetPath) {
		Map param = new HashMap();
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				// 1. 创建DiskFileItemFactory对象，设置缓冲区大小和临时文件目录
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// 2. 创建ServletFileUpload对象，并设置上传文件的大小限制。
				ServletFileUpload sfu = new ServletFileUpload(factory);
				sfu.setSizeMax(10 * 1024 * 1024);// 以byte为单位 不能超过10M

				sfu.setHeaderEncoding("utf-8");
				// 3.调用ServletFileUpload.parseRequest方法解析request对象，得到一个保存了所有上传内容的List对象。
				@SuppressWarnings("unchecked")
				List<FileItem> fileItemList = sfu.parseRequest(request);
				Iterator<FileItem> fileItems = fileItemList.iterator();
				// 4. 遍历list，每迭代一个FileItem对象，调用其isFormField方法判断是否是上传文件

				while (fileItems.hasNext()) {
					FileItem fileItem = fileItems.next();
					// 普通表单元素
					if (fileItem.isFormField()) {
						String name = fileItem.getFieldName();// name属性值
						String value = fileItem.getString("utf-8");// name对应的value值
						param.put(fileItem.getFieldName(), fileItem.getString("utf-8"));
						System.out.println(name + " = " + value);
					}
					// <input type="file">的上传文件的元素
					else {
						String fileName = fileItem.getName();// 文件名称
						String gid=request.getParameter("gid");
						if (!fileName.equals("")) {
							System.out.println("原文件名：" + fileName);// Koala.jpg
							String suffix = fileName.substring(fileName.lastIndexOf('.'));
							System.out.println("扩展名：" + suffix);// .jpg
							SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
							// 新文件名（唯一）
							String newFileName;
							if(gid==null){
								newFileName = sdf.format(new Date()) + suffix;
							}else{
								newFileName = gid+ suffix;
							}
							
							System.out.println("新文件名：" + newFileName);// image\1478509873038.jpg
							// 5. 调用FileItem的write()方法，写入文件
							param.put("gimage", newFileName);
							File file = new File(targetPath + newFileName);
							System.out.println(file.getAbsolutePath());
							fileItem.write(file);
							// 6. 调用FileItem的delete()方法，删除临时文件
							fileItem.delete();

						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return param;
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
		HttpSession session = request.getSession();
		String gid = request.getParameter("gid");
		User user1 = userDao.findById(gid);
		Map<String,String> map = copyImage(request, ClubConstants.USER_IMG_PATH);
		if(map.size()>0){
			if (map.get("gimage")== null || map.get("gimage").equals("")) {// 未更换头像,使用原来的头像
				map.put("gimage", map.get("defaultimg"));
			}
			if(map.get("level")==null){
				map.put("level",session.getAttribute("level").toString());
			}
			User user=new User(map.get("gusername"),map.get("gmail"), map.get("gtel"), map.get("gsex"),Integer.parseInt(map.get("level")), map.get("gimage"), map.get("gtitle"));			
			if (user.getGpwd() == null) {// 进入更新用户信息操作			
				if (user.getGusername().equals(user1.getGusername())) {// 未对用户名进行修改.不修改用户名也算是修改,也可以修改其他的
					userDao.editUser(user, gid);
					log.debug("修改用户信息成功!");
				} else {// 已对用户名进行修改
					if (userDao.exist(user).equals("noexist")) {// 新用户名
						userDao.editUser(user, gid);
						log.debug("修改用户信息成功!");
						session.setAttribute("name", user.getGusername());				
					} else {// 用户名已存在
						log.debug("该用户名已存在,修改用户信息失败!!!");	
						request.setAttribute("error", "该用户名已存在!用户名修改失败");
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
				}

			}
			return reloadAccount(request,response);
		}else {
			return reloadAccount(request,response);
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
