package net.blog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.blog.db.DbCon;
import net.blog.dao.*;
import net.blog.bean.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.regex.Pattern;

public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 112341234L;
       
    public UserServlet() {
        super();
    }
    
    private boolean isInteger(String s) {
    	Pattern p = Pattern.compile("^[1-9][0-9]*$");
    	return p.matcher(s).matches();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String param = request.getParameter("param");
		System.out.print("UserServlet param => ");
		System.out.println(param);
		HttpSession session = request.getSession();
		switch (param) {
		case "signup":
			String name = request.getParameter("signup_name").trim();
			String pwd = request.getParameter("signup_password").trim();
			String eml = request.getParameter("signup_email").trim();
			String tel = request.getParameter("signup_tel").trim();
			String age = request.getParameter("signup_age").trim();
			if (pwd == "") {
				pwd = "blank";
			}
			if (eml == "") {eml = "blank@blank.com";}
			if (tel == "") {tel = "000000"; }
			if (age == "") {age = "1"; }
			if (isInteger(age)) {
				if (Integer.parseInt(age) > 150) {
					age = "0";
				}
			}
			session.setAttribute("signup_name",name);
			Connection con = DbCon.getDbConn();
			if (con != null) {
				try {
					Statement s = con.createStatement();
					String check = "select * from weibo.user where user_name = '" + name + "';";
					String query = "insert into weibo.user(user_name, user_pwd, user_email, user_tel, user_age) " 
							+ "values ('"+ name + "', '" + pwd + "', '" + eml + "', '" + tel + "', " + age + ");" ;
					System.out.print("Insert user ~> ");
					System.out.println(query);
					try{
						ResultSet rs =  s.executeQuery(check);
						try {
							if (rs.next()) {
								System.out.print("Insert user failed, duplicated username");
								response.sendRedirect("dup_user.jsp");
							} else {
								s.executeUpdate(query);
								System.out.print("Insert user successfully");
								response.sendRedirect("login.jsp");
							}
						} finally {
							rs.close();
						}
					}finally{ 
						s.close(); 
					}
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println(e.getMessage());
				} finally{
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		case "addFriend":
			response.sendRedirect("add_friend.jsp");
			break;
		case "searchFriend":
			String fname = request.getParameter("friend_name");
			System.out.print("friend name => ");
			System.out.println(fname);
			UserDao ud = new UserDao();
			ArrayList<User> ul = ud.searchUsersByUser(fname);
			session.setAttribute("friendlist", ul);
			response.sendRedirect("add_friend.jsp");
			break;
		case "linkFriend":
			String f1 = (String) session.getAttribute("login_name");
			String f2 = (String) request.getParameter("f2name");
			System.out.println("f1 => " + f1);
			System.out.println("f2 => " + f2);
			Connection con1 = DbCon.getDbConn();
			if (con1 != null) {
				try {
					Statement s = con1.createStatement();
					String check1 = "select * from weibo.friend where f1_name = '"
									+ f1 + "' and f2_name = '" + f2 + "';";
					String query1 = "insert into weibo.friend(f1_name, f2_name, friend_type) "
							+ "values ('" + f1 + "', '" + f2 + "', '0');" ;
					System.out.println(check1);
					System.out.print("Link friend ~> ");
					System.out.println(query1);
					try{
						ResultSet rs =  s.executeQuery(check1);
						try {
							if (rs.next()) {
								System.out.println("Linking user failed, they hace been friends already");
								response.sendRedirect("userhome.jsp");
							} else {
								s.executeUpdate(query1);
								System.out.println("Linking user successfully");
								response.sendRedirect("userhome.jsp");
							}
						} finally {
							rs.close();
						}
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
		case "listFriend":
			String username = (String) session.getAttribute("login_name");
			System.out.print("user name => ");
			System.out.println(username);
			response.sendRedirect("list_friend.jsp");
			break;
		case "delFriend":
			String f11 = (String) session.getAttribute("login_name");
			String f21 = (String) request.getParameter("f2name");
			System.out.println("f11 => " + f11);
			System.out.println("f21 => " + f21);
			Connection con11 = DbCon.getDbConn();
			if (con11 != null && f11 != null && f21 != null) {
				try {
					Statement s = con11.createStatement();
					String query1 = "delete from weibo.friend where f1_name = '"
						 + f11 + "' and f2_name = '" + f21 + "';" ;
					System.out.print("Delete friend ~> ");
					System.out.println(query1);
					try{
						s.executeUpdate(query1);
						response.sendRedirect("list_friend.jsp");
					}finally{ 
						s.close(); 
					}
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println( e.getMessage());
				} finally{
					try {
						con11.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		case "visitFriend":
			String visit = (String) request.getParameter("f2name");
			System.out.println("U visitFriend visit => " + visit);
			session.setAttribute("visit", visit);
			response.sendRedirect("friend_weibo.jsp");
			break;
		default:
			System.out.println("BUG;Userservlet");
		}
	}
}
