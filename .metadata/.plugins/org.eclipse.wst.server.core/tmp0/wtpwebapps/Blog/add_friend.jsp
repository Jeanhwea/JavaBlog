<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="net.blog.bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="net.blog.db.DbCon" %>
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
<title>Add friend</title>
</head>
<body>
<table>
	<tr><td><p><a href="userhome.jsp">HOME</a></p></td></tr>
</table>
<table>
	<form id="add_friend" method="post" action="/Blog/userdo?param=searchFriend">
			<tr>
				<td>输入好友昵称：</td>
				<td> <input id="friend_name" type="text" name="friend_name"> </td>
				<td> <input id="add" type="submit" value="查找"></td>
			</tr>
	</form>
</table>
<% 
	ArrayList<User> ul = (ArrayList<User>) session.getAttribute("friendlist");
	boolean find = false;
	if (ul != null) {
		Iterator<User> its = ul.iterator();
		while (its.hasNext()) {
			User it = its.next();
			find = true;
%>
	<form method="post" action="/Blog/userdo?param=linkFriend">
		<table>
		<%="<input id=\"friend_" + it.getName() + "\" type=\"hidden\" name=\"f2name\" " + "value=\"" + it.getName()+"\">"%>
	<tr>
		<td><%="<input id=\"add_" + it.getName() + "\" type=\"submit\" " + "value=\"添加好友\">"%></td>
		<td><%=" ---> "+it.getName() %></td>
	</tr>
	<hr/>
		</table>
	</form>
<%		} %>
<%  } %>
<table><hr/></table>
<% 
	if (find == false && ul != null) {
%><table><strong>未找到与该用户名相关的用户</strong></table>
	<table><hr/></table>
<%}%>
</body>
</html>