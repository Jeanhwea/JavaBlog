<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="net.blog.db.DbCon" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String username = request.getParameter("login_name");
	String password = request.getParameter("login_password");
	String usertype = request.getParameter("usertype");
	session.setAttribute("login_name",username);
	session.setAttribute("login_password",password);
	session.setAttribute("usertype", usertype);
	System.out.println("login_name => " + username);
	System.out.println("login_password => " + password);
	System.out.println("User type => " + usertype);
	
	switch (Integer.parseInt(usertype)) {
	case 1:
		System.out.println("$$$$$$");	
		response.sendRedirect("userhome.jsp");
		break;
	case 2:
		System.out.println("%%%%%%");
		response.sendRedirect("admin_home.jsp");
		break;
	default:
		break;
	}
%>
