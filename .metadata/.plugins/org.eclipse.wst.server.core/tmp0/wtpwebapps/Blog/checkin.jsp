<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="net.blog.db.DbCon" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String username = request.getParameter("login_name");
	String password = request.getParameter("login_password");

	System.out.println("login_name => " + username);
	System.out.println("login_password => " + password);
	Connection con = DbCon.getDbConn();
	Statement stmt = con.createStatement();
	String query = "select * from user where user_name='"
			+ username + "' and user_pwd = '" + password + "'";
	System.out.println(query);
	ResultSet rs = stmt.executeQuery(query);
	if (rs.next()) {
		System.out.println("passed check... login");
		session.setAttribute("login_name",username);
		session.setAttribute("login_password",password);
		response.sendRedirect("userhome.jsp");
	} else {
		System.out.println("failed to pass check... ");
		response.sendRedirect("login_fail.jsp");
	}
	rs.close();
	stmt.close();
	con.close();
%>
