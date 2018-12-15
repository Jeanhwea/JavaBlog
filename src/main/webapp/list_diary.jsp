<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="net.blog.bean.Diary" %>
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
        <title>Diary list</title>
    </head>
    <body>
        <table>
            <tr><td><p><a href="userhome.jsp">HOME</a></p></td></tr>
        </table>
        <%
        DiaryDao dd = new DiaryDao();
        ArrayList<Diary> dl = dd.getDiaryByUser(username);
        boolean find = false;
        if (dl != null) {
            Iterator<Diary> its = dl.iterator();
            while (its.hasNext()) {
                Diary it = its.next();
                find = true;
        %>
        <table>
            <tr>
                <td>标题 ： </td>
                <td><strong><%= it.getTitle()%></strong></td>
            </tr>
            <tr>
                <td><p>内容：</p></td>
                <td><%= it.getText().replace("\n", "<br/>") %></td>
            </tr>
            <tr>
                <form method="post" action="/blog/diarydo?param=delDiary">
                    <td>
                        <%="<input id=\"diax_" + it.getId() + "\" type=\"hidden\" name=\"diary_id\" value = \"" + it.getId() + "\">"%>
                        <%="<input id=\"diaxx_" + it.getId() + "\" type=\"submit\" " + "value=\"删除日志\">"%>
                    </td>
                </form>
                <td><%= it.getDate() %></td>
            </tr>
            <hr/>
        </table>
<%		} %>
<%  } %>
<table><hr/></table>
<%
if (find == false && dl != null) {
%>
    <table><strong>还未写过日志</strong></table>
    <table><hr/></table>
<%}%>
    </body>
</html>
