package com.gx.servlet;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.gx.dao.SchoolDao;
import com.gx.entity.School;
import com.gx.pager.ClubConstants;
import com.gx.pager.PageBean;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

/**
 * 校内活动增删改成
 * 
 * @author Administrator
 *
 */
public class SchoolServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private SchoolDao ns = new SchoolDao();
	Logger log = Logger.getLogger(SchoolServlet.class);

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
		Map<String, String> map = copyImage(request, ClubConstants.ACTIVE_IMG_PATH);
		if (map.size() > 0) {
			if (map.get("gimage") == null || map.get("gimage").equals("")) {// 未更换头像,使用原来的头像
				map.put("gimage", map.get("gtupian"));
			}
			School school = new School(map.get("gtheme"), map.get("gpart"), map.get("gtime"), map.get("gcontent"),
					map.get("gusername"), Integer.parseInt(map.get("gperson")), map.get("gprice"), map.get("gplace"),
					map.get("gimage"), map.get("gremain"));
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
		School school = this.ns.findById(gid);
		request.setAttribute("school", school);
		request.setAttribute("gid", gid);
		request.setAttribute("type", school.getGflag());
		return "f:/adminjsps/editschool.jsp";
	}

	/**
	 * 删除活动
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
		log.debug("删除校内活动成功!");
		return findAll(request, response);
	}

	/**
	 * 增加活动
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
		Map<String, String> map = copyImage(request, ClubConstants.ACTIVE_IMG_PATH);
		if (map.size() > 0) {
			School school = new School(map.get("gtheme"), map.get("gpart"), map.get("gtime"), map.get("gcontent"),
					map.get("gusername"), Integer.parseInt(map.get("gperson")), map.get("gprice"), map.get("gplace"),
					map.get("gimage"), map.get("gremain"));
			String type = map.get("type");
			request.setAttribute("type", type);
			school.setGcontent(school.getGcontent().trim());
			school.setGflag(Integer.parseInt(type));
			//ns.addSchool(school);
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
		String type = request.getParameter("type");		
		String s=(String) request.getAttribute("type");
		if(type==null){
			type=s;
		}
		if (place != null) {
			place = URLDecoder.decode(place, "utf8");
		}
		int curPage = getPc(request);
		if (curPage <= 1) {
			curPage = 1;
		}
		PageBean<School> pb = this.ns.findAll(curPage, datefrom, dateto, place, type);
		request.setAttribute("type", type);
		request.setAttribute("pb", pb);
		request.setAttribute("curPage", pb.getPc());
		request.setAttribute("datefrom", datefrom);
		request.setAttribute("dateto", dateto);
		request.setAttribute("place", place);
		// request.setAttribute("type", "inschool");
		// request.getRequestDispatcher("/WEB-INF/bai/main.jsp").forward(request,
		// response);
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
							String newFileName=null;
							// 新文件名（唯一）
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
}
