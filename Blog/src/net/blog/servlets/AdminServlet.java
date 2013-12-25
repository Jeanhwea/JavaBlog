package net.blog.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.blog.db.DbCon;


public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1451345123L;
       
    public AdminServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String param = request.getParameter("param");
		System.out.print("AdminServlet param => ");
		System.out.println(param);
//		HttpSession session = request.getSession();
		switch (param) {
		case "delUser":
			String uname = request.getParameter("uname");
			System.out.println("uname => "+uname);
			Connection con = DbCon.getDbConn();
		if (con != null && uname != null) {
			try {
				Statement s = con.createStatement();
				String query1 = "delete from weibo.user where user_name = '" + uname + "';" ;
				System.out.print("Delete user by admin ~> ");
				System.out.println(query1);
				try{
					s.executeUpdate(query1);
					response.sendRedirect("admin_home.jsp");
				}finally{ 
					s.close(); 
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println( e.getMessage());
			} finally{
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
			break;
		case "changePwd":
		String uname1 = request.getParameter("uname");
		String pwd = request.getParameter("password");
		System.out.println("uname => "+uname1);
		System.out.println("password change to => " + pwd);
		Connection con1 = DbCon.getDbConn();
	if (con1 != null && uname1 != null && pwd != null) {
		try {
			Statement s = con1.createStatement();
			String query1 = "update weibo.user set user_pwd = '" + pwd + "' where user_name = '" + uname1 + "';" ;
			System.out.print("Delete user by admin ~> ");
			System.out.println(query1);
			try{
				s.executeUpdate(query1);
				response.sendRedirect("admin_home.jsp");
			}finally{ 
				s.close(); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println( e.getMessage());
		} finally{
			try {
				con1.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
			break;
		default:
			System.out.println("BUG;Adminservlet");
		}
	}

}
