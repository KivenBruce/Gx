package com.gx.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gx.dao.UserDao;
import com.gx.dao.VisitDao;
import com.gx.entity.User;

import cn.itcast.commons.CommonUtils;
import sun.misc.BASE64Encoder;

@WebServlet({"/LoginServlet"})
public class LoginServlet
  extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  private UserDao userDao = new UserDao();
  
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doPost(request, response);
  }
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    HttpSession session = request.getSession();
    String username = (String)session.getAttribute("name");
    if ((username != null) && (request.getParameter("pwd") == null))
    {
      session.setMaxInactiveInterval(600);
      
      VisitDao visitDao = new VisitDao();
      Date date = new Date();
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      String format = sdf.format(date);
      try
      {
        Date newdate = sdf.parse(format);
        visitDao.updateVisit(newdate);
      }
      catch (ParseException e)
      {
        e.printStackTrace();
      }
      try
      {
        Date vdate = sdf.parse(format);
        List<Integer> selectDetail = visitDao.selectDetail(vdate);
        int allv = ((Integer)selectDetail.get(0)).intValue();
        int todayv = ((Integer)selectDetail.get(1)).intValue();
        session.setAttribute("allv", Integer.valueOf(allv));
        session.setAttribute("todayv", Integer.valueOf(todayv));
        request.getRequestDispatcher("/WEB-INF/bai/main.jsp").forward(request, response);
      }
      catch (ParseException e)
      {
        e.printStackTrace();
      }
    }
    else
    {
      String password = request.getParameter("pwd");
      if (password != null) {
        try
        {
          MessageDigest md5 = MessageDigest.getInstance("MD5");
          BASE64Encoder base64en = new BASE64Encoder();
          String passEncode = base64en.encode(md5.digest(password.getBytes("utf-8")));
          User formUser = (User)CommonUtils.toBean(request.getParameterMap(), User.class);
          formUser.setGusername(request.getParameter("name"));
          formUser.setGpwd(passEncode);
          User user = userDao.login(formUser.getGusername(),formUser.getGpwd());
          if (user == null)//验证用户名和密码两项是否都符合
          {
            request.setAttribute("mark", "none");
            request.setAttribute("username", request.getParameter("name"));
            request.getRequestDispatcher("/login.jsp").forward(request, response);
          }
          else
          {
            String image = request.getParameter("lab1");
            String code = (String)request.getSession().getAttribute("code");
            if (!image.equals(code))
            {
              request.setAttribute("mark", "failure");
              request.setAttribute("username", request.getParameter("name"));
              request.setAttribute("password", request.getParameter("pwd"));
              request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            else
            {
              session.setAttribute("name", request.getParameter("name"));
              session.setAttribute("pwd", password);
              session.setAttribute("level", user.getLevel());
              session.setMaxInactiveInterval(600);
              
              VisitDao visitDao = new VisitDao();
              Date date = new Date();
              SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
              String format = sdf.format(date);
              try
              {
                Date newdate = sdf.parse(format);
                visitDao.updateVisit(newdate);
              }
              catch (ParseException e)
              {
                e.printStackTrace();
              }
              if (user.getLevel() == 1)
              {
                Date vdate = sdf.parse(format);
                List<Integer> selectDetail = visitDao.selectDetail(vdate);
                int allv = ((Integer)selectDetail.get(0)).intValue();
                int todayv = ((Integer)selectDetail.get(1)).intValue();
                session.setAttribute("allv", Integer.valueOf(allv));
                session.setAttribute("todayv", Integer.valueOf(todayv));
                response.sendRedirect("http://localhost:8080/Gx/adminjsps/index1.jsp");
              }
              else
              {
                request.getRequestDispatcher("/WEB-INF/bai/main.jsp").forward(request, response);
              }
            }
          }
        }
        catch (NoSuchAlgorithmException e)
        {
          e.printStackTrace();
        }
        catch (ParseException e)
        {
          e.printStackTrace();
        } catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
      } else {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
      }
    }
  }
}
