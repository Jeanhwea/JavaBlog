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
	String visit = (String) session.getAttribute("visit");

	System.out.println("session login_name => " + username);
	System.out.println("session login_password => " + password);
	System.out.println("session visit => " + visit);

	
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
<title>Friend list</title>
</head>
<body>
<p><a href="userhome.jsp">HOME</a></p>
<table>
	<%
		WeiboDao wd = new WeiboDao();
		ArrayList<Weibo> wl = wd.getWeiboByUser(visit);
		Iterator<Weibo> its = wl.iterator();
		while (its.hasNext()) {
			Weibo it = (Weibo)its.next();
	%>
	<tr><td>
		<table>
		<hr/>
		<tbody>
		<tr>
			<td><p><%=it.getUser_name()%> 说：</p></td>
			<td><strong><p><%=it.getText()%></p></strong></td>
		</tr>
		<%
			CommDao cd = new CommDao();
			ArrayList<Comm> cl = cd.getCommByWeibo(Integer.parseInt(it.getId()));
			Iterator<Comm> xits = cl.iterator();
			while (xits.hasNext()) {
				Comm xit = (Comm) xits.next();
		%>
		<tr>
			<td><p><%= xit.getName()%> 评论：</p></td>
			<td><%= xit.getText() %></td>
		</tr>
		<%
			}
		%>
		<form method="post" action="/Blog/weibodo?param=addCommf">
		<%="<input id=\"weic" + it.getId() + "\" type=\"hidden\" name=\"weiboc_id\" " + "value=\""+ it.getId()+"\">"%>
		<tr>
			<td><%="<input id=\"submit_" + it.getId() + "\" type=\"submit\" name=\"comm_id\" " + "value=\"评论\">"%></td>
			<td><textarea name="comment_text"></textarea></td>
		</tr>
		</form>
		</tbody>
		</table>
	</td></tr>
	<% } %>
</table>
</body>
</html>