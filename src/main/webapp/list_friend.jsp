<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="net.blog.bean.Friend" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="net.blog.db.DbCon" %>
<%@ page import="net.blog.dao.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String username = (String) session.getAttribute("login_name");
String password = (String) session.getAttribute("login_password");

System.out.println("session login_name => " + username);
System.out.println("session login_password => " + password);

Connection con = DbCon.getDbConn();
Statement stmt = con.createStatement();
String query = "select * from user where user_name='" + username + "' and user_pwd = '" + password + "'";
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
        <title>List friend</title>
    </head>
    <body>
        <p><a href="userhome.jsp">HOME</a></p>
        <%
        UserDao ud1 = new UserDao();
        ArrayList<Friend> fl = ud1.searchFriendsByUser(username);
        boolean find = false;
        if (fl != null) {
            Iterator<Friend> its = fl.iterator();
            while (its.hasNext()) {
                Friend it = its.next();
                find = true;
        %>

        <table>
            <tr>
                <td><p>好友姓名 ： </p></td>
                <td><strong><%= it.getF2_name()%></strong></td>
            </tr>
            <tr>
                <form method="post" action="/blog/userdo?param=delFriend">
                    <td>
                        <%="<input id=\"frix_" + it.getF2_name() + "\" type=\"hidden\" name=\"f2name\" value = \"" + it.getF2_name() + "\">"%>
                        <%="<input id=\"frixx_" + it.getF2_name() + "\" type=\"submit\" " + "value=\"解除好友关系\">"%>
                    </td>
                </form>
                <form method="post" action="/blog/userdo?param=visitFriend">
                    <td>
                        <%="<input id=\"frir_" + it.getF2_name() + "\" type=\"hidden\" name=\"f2name\" value = \"" + it.getF2_name() + "\">"%>
                        <%="<input id=\"frirr_" + it.getF2_name() + "\" type=\"submit\" " + "value=\"访问好友空间\">"%>
                    </td>
                </form>
            </tr>
            <hr/>
        </table>
<%		} %>
<%  } %>
<table><hr/></table>
<%
if (find == false && fl != null) {
%><table><strong>还未添加好友</strong></table>
    <table><hr/></table>
<%}%>
    </body>
</html>
