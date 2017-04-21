package com.gx.servlet;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.gx.dao.FrontDao;
import com.gx.entity.Navigate;
import com.gx.entity.School;
import com.gx.pager.ClubConstants;
import com.gx.pager.PageBean;

import cn.itcast.servlet.BaseServlet;

public class FrontServlet extends BaseServlet{
	private static final long serialVersionUID = 1L;
	Logger log = Logger.getLogger(this.getClass());
	private FrontDao fid = new FrontDao();

	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		
		String type=request.getParameter("type");
		PageBean<School> pbtui = fid.listTui(type);//推荐活动
		List<School> tuibeanList = pbtui.getBeanList();
		request.setAttribute("tuibeanList", tuibeanList);
		
		PageBean<School> pbnew= fid.listNew(type);//最新活动
		List<School> newbeanList = pbnew.getBeanList();
		request.setAttribute("newbeanList", newbeanList);
		
		PageBean<Navigate> pbnav= fid.listNav(type);//导航活动
		List<Navigate> navbeanList = pbnav.getBeanList();
		request.setAttribute("navbeanList", navbeanList);
		int[] Gadv=new int[4];
		String[] Gurl=new String[4];
		for(int i=0;i<navbeanList.size();i++){
			Gadv[i]=navbeanList.get(i).getGadv();
			Gurl[i]=navbeanList.get(i).getGurl();
		}
		request.setAttribute("Gadv", Gadv);
		request.setAttribute("Gurl", Gurl);
		if(type.equals("in")){
			return "f:/WEB-INF/bai/inschool.jsp";
		}else{
			return "f:/WEB-INF/bai/outschool.jsp";
		}
		
	}
	
	/**
	 * 查看更多活动
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 */
	public String moreActive(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		String type=request.getParameter("type");
		int curPage = getPc(request);
		PageBean<School> pb = fid.moreActive(curPage,type);
		request.setAttribute("pb", pb);
		request.setAttribute("curPage", curPage);
		request.setAttribute("type", type);
		return "f:/WEB-INF/bai/showmore.jsp";
	}
	/**
	 * 主页点击查看活动详情
	 * 更多列表点击查看详细
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 */
	public String navDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String gid = request.getParameter("gid");
		String type = request.getParameter("type");
		if(type.equals("nav")){//导航详情
			Navigate navdetail = fid.searchById(gid,type);
			request.setAttribute("navdetail", navdetail);
			return "f:/navdetail.jsp";
		}else{//非导航
			School school = fid.searchById(gid,type);
			request.setAttribute("school", school);
			return "f:/searchdetail.jsp";
		}
		
	}
	
	/**
	 * 普通会员查找所有相关活动
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public String searchAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String question = request.getParameter("q");
		String gflag = request.getParameter("gflag");
		int curPage = getPc(request);
		if (curPage <= 1) {
			curPage = 1;
		}
		PageBean<School> pb = fid.searchAll(gflag, curPage, question);
		if (curPage >= pb.getPageCount()) {
			curPage = pb.getPageCount();
		}
		request.setAttribute("pb", pb);
		request.setAttribute("curPage", Integer.valueOf(curPage));
		request.setAttribute("question", question);
		request.setAttribute("gflag", gflag);
		return "f:/searchlist.jsp";
	}

	/**
	 * 查询搜索页列表点击查看活动详情
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 */
	public String actDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String gid = request.getParameter("gid");
		School school = fid.searchByIdFlag(gid);
		request.setAttribute("school", school);
		return "f:/searchdetail.jsp";
	}
	
	/**
	 * 处理导航图片
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void navImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/octet-stream;charset=UTF-8");
		String file = request.getParameter("filepath");
		if (!file.isEmpty()) {
			String target = ClubConstants.NAV_IMG_PATH + file;
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
	
	/**
	 * 处理图片方法
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void doImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/octet-stream;charset=UTF-8");
		String file = request.getParameter("filepath");
		if (!file.isEmpty()) {
			String target = ClubConstants.ACTIVE_IMG_PATH + file;
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
	private int getPc(HttpServletRequest req) {
		int pc = 1;
		String param = req.getParameter("curPage");
		if ((param != null) && (!param.trim().isEmpty())) {
			try {
				pc = Integer.parseInt(param);
				if (pc <= 1) {
					pc = 1;
				}
			} catch (RuntimeException localRuntimeException) {
			}
		}
		return pc;
	}
}
