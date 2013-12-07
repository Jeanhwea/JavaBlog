<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="net.blog.db.DbCon" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="net.blog.bean.*"%>
<%@ page import="net.blog.dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String username = (String) session.getAttribute("login_name");
	String password = (String) session.getAttribute("login_password");

	System.out.println("session login_name => " + username);
	System.out.println("session login_password => " + password);
	
	Connection con = DbCon.getDbConn();
	Statement stmt = con.createStatement();
	String query = "select * from user where user_name='"
			+ username + "' and user_pwd = '" + password + "'";
	System.out.println(query);
	ResultSet rs = stmt.executeQuery(query);
	if (rs.next()) {
		System.out.println("valid user check in userhome");
	} else {
		System.out.println("failed to pass check userhome ... unvalid user");
		response.sendRedirect("login_fail.jsp");
	}
	rs.close();
	stmt.close();
	con.close();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Write Diary</title>
</head>
<body>
<table>
	<tr><td><p><a href="userhome.jsp">HOME</a></p></td></tr>
</table>
<form id="writerizhi" method="post" action="/Blog/diarydo?param=addDiary">
	<table>
		<tr>
			<td><span>标题：</span></td>
			<td>
			<input id="title" type="text" name="diary_title" size="60"/>
			</td>
		</tr>
		<tr>
			<td><span>内容：</span></td>
			<td>
			<textarea name="diary_text" rows="30" cols="60"></textarea>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><input id="submit" type="submit" name="submit" value="提交"></td>
		</tr>
	</table>
</form>
</body>
</html>