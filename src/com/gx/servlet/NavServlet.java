package com.gx.servlet;

import java.io.File;
import java.io.IOException;
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

import com.gx.dao.NavDao;
import com.gx.entity.Navigate;
import com.gx.pager.ClubConstants;
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
		// int radio = Integer.parseInt(request.getParameter("aa"));
		Map<String, String> map = copyImage(request, ClubConstants.NAV_IMG_PATH);
		if (map.size() > 0) {
			if (map.get("aa").equals("0")) {
				map.put("gurl", "0");
			} else {
				map.put("gurl", "http://" + map.get("gurl"));
			}
			if (map.get("gimage") == null) {
				map.put("gimage", map.get("gtupian"));
			}
			Navigate navigate = new Navigate(map.get("gtheme"), map.get("gpart"), map.get("gtime"), map.get("gcontent"),
					map.get("gusername"), Integer.parseInt(map.get("gperson")), map.get("gprice"), map.get("gplace"),
					map.get("gimage"), Integer.parseInt(map.get("aa")), map.get("gurl"), map.get("gremain"));
			navigate.setGcontent(navigate.getGcontent().trim());
			nd.editNavigate(navigate, gid, type);
			log.debug("修改校内导航成功!");
			return findAll(request, response);

		} else {
			request.setAttribute("msg", "导航修改页面");
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
						if (!fileName.equals("")) {
							System.out.println("原文件名：" + fileName);// Koala.jpg
							String suffix = fileName.substring(fileName.lastIndexOf('.'));
							System.out.println("扩展名：" + suffix);// .jpg
							SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
							// 新文件名（唯一）
							String newFileName = request.getParameter("gid")+suffix;//sdf.format(new Date()) +suffix;
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
