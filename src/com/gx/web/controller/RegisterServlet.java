package com.gx.web.controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.dbutils.QueryRunner;

import com.gx.user.dao.UserDao;
import com.gx.user.domain.User;

import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;
import sun.misc.BASE64Encoder;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao = new UserDao();
	private QueryRunner qr = new TxQueryRunner();

	public RegisterServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User formUser = CommonUtils.toBean(request.getParameterMap(), User.class);
		formUser.setGusername(request.getParameter("name"));
		formUser.setGpwd(request.getParameter("pwd"));
		User user=null;
		try {
			user = userDao.regist(formUser.getGusername());
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		if (user != null) {
			request.setAttribute("mark", "have");
			request.setAttribute("username", request.getParameter("name"));
			request.setAttribute("pwd", request.getParameter("pwd"));
			request.setAttribute("pwd2", request.getParameter("pwd2"));
			request.setAttribute("email", request.getParameter("email"));
			request.setAttribute("tel", request.getParameter("tel"));
			request.getRequestDispatcher("/WEB-INF/bai/register.jsp").forward(request, response);
		} else {
			String sql = "insert into Guser(Gusername,Gpwd,level,Gmail,Gtel) values(?,?,3,?,?)";
			String password = request.getParameter("pwd");
			MessageDigest md5;
			try {
				md5 = MessageDigest.getInstance("MD5");
				BASE64Encoder base64en = new BASE64Encoder();
				String passEncode = base64en.encode(md5.digest(password.getBytes("utf-8")));
				Object[] params = { request.getParameter("name"), passEncode, request.getParameter("email"),
						request.getParameter("tel")};
				try {
					qr.update(sql, params);
				} catch (SQLException e) {
					throw new RuntimeException(e);
				}
				response.setCharacterEncoding("UTF-8");
				request.getRequestDispatcher("/WEB-INF/bai/login.jsp").forward(request, response);
			} catch (NoSuchAlgorithmException e1) {
				e1.printStackTrace();
			}

		}
	}

}
