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
        <title>Timeline</title>
    </head>
    <body>
        <p><a href="userhome.jsp">HOME</a></p>
        <table>
            <%
            username = (String) session.getAttribute("login_name");
            TimelineDao td = new TimelineDao();
            ArrayList<Timeline> tl = td.getTimelineByUser(username);
            Iterator<Timeline> its = tl.iterator();
            while (its.hasNext()) {
                Timeline it = (Timeline)its.next();
            %>
            <tr><td>
                <table>
                    <hr/>
                    <tr><td>
                        <%= it.getTline_time() + ": " %>
                    </td>
                    <td><strong><%= it.getTline_action() %></strong></td>
                    </tr>
                </table>
            </td></tr>
    <% } %>
        </table>
    </body>
</html>
