<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="net.blog.bean.*"%>
<%@ page import="net.blog.dao.*" %>
<%@ page import="net.blog.db.DbCon" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String username = (String) session.getAttribute("login_name");
	String password = (String) session.getAttribute("login_password");

	System.out.println("session login_name => " + username);
	System.out.println("session login_password => " + password);

	
	Connection con = DbCon.getDbConn();
	Statement stmt = con.createStatement();
	String query = "select * from admin where adm_name='"
			+ username + "' and adm_pwd = '" + password + "'";
	System.out.println(query);
	ResultSet rs = stmt.executeQuery(query);
	if (rs.next()) {
		System.out.println("valid user check in admin_Home");
	} else {
		System.out.println("failed to pass check userhome ... unvalid admin");
		response.sendRedirect("login_fail.jsp");
	}
	rs.close();
	stmt.close();
	con.close();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin</title>
</head>
<body>
<% 
	AdminDao ud1 = new AdminDao();
	ArrayList<User> ul = ud1.searchUsersByUser("");
	boolean find = false;
	if (ul != null) {
		Iterator<User> its = ul.iterator();
		while (its.hasNext()) {
			User it = its.next();
			find = true;
%>
		<table>
	<tr>
		<td><p>用户姓名 ： </p></td>
		<td><strong><%= it.getName()%></strong></td>
	</tr>
	<tr><td>
		<form method="post" action="/Blog/admindo?param=delUser">	
<%="<input id=\"frix_" + it.getName() + "\" type=\"hidden\" name=\"uname\" value=\""
					+ it.getName() + "\">"%>
<%="<input id=\"frixx_" + it.getName() + "\" type=\"submit\" " + "value=\"删除\">"%>
		</form></td>
	</tr>
	<tr>	
		<form method="post" action="/Blog/admindo?param=changePwd">	
	
<%="<input id=\"frixp_" + it.getName() + "\" type=\"hidden\" name=\"uname\" value=\""
					+ it.getName() + "\">"%>
<td>
<%="<input id=\"frixpx_" + it.getName() + "\" type=\"submit\" " + "value=\"改密码\">"%>
</td>
<td>
<%="<input id=\"frixpx_" + it.getName() + "\" type=\"text\" name=\"password\" " + "value=\"123\">"%>
</td>
		</form>

	</tr>
	<hr/>
		</table>
<%		} %>
<%  } %>
<table><hr/></table> 
</body>
</html>