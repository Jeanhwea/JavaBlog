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
        <title>Home</title>
    </head>
    <body>
        <table>
            <tr>
                <td><p><a href="userhome.jsp">HOME</a></p></td>
                <td> <p> </p> </td>
                <td><p><a href="/blog/diarydo?param=listDiary">DARIY</a></p></td>
                <td> <p> </p> </td>
                <td><p><a href="/blog/time_line.jsp">TIMELINE</a></p></td>
            </tr>
        </table>

        <table>
            <tr>
                <td>
                    <form method="post" action="/blog/weibodo?param=addWeibo">
                        <table>
                            <tr>
                                <td>
                                    <input id="weibo_text" type="text" name="weibo_text" size="50">
                                </td>
                                <td>
                                    <input id="weibo_text_submit" type="submit" value="发微">
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <form method="post" action="/blog/write_diary.jsp " >
                                    <input id="addFriend" type="submit" value="写日志">
                                </form>
                            </td>
                            <td>
                                <form method="post" action="/blog/userdo?param=addFriend " >
                                    <input id="addFriend" type="submit" value="加好友">
                                </form>
                            </td>
                            <td>
                                <form method="post" action="/blog/userdo?param=listFriend" >
                                    <input id="listFriend" type="submit" value="好友列表">
                                </form>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <%
            WeiboDao wd = new WeiboDao();
            ArrayList<Weibo> wl = wd.getWeiboByUser(username);
            Iterator<Weibo> its = wl.iterator();
            while (its.hasNext()) {
                Weibo it = (Weibo) its.next();
            %>
            <tr>
                <td>
                    <table>
                        <hr/>
                        <tbody>
                            <tr>
                                <td><p><%=it.getUser_name()%> 说：</p></td>
                                <td><strong><p><%=it.getText()%></p></strong></td>
                            </tr>
                            <form method="post" action="/blog/weibodo?param=delWeibo">
                                <%="<input id=\"wei" + it.getId() + "\" type=\"hidden\" name=\"weibo_id\" " + "value=\""+ it.getId()+"\">"%>
                                <tr>
                                    <td><%="<input id=\"submit_" + it.getId() + "\" type=\"submit\" name=\"weibo_id\" " + "value=\"删除\">"%></td>
                                    <td><p><%=it.getDate()%></p></td>
                                </tr>
                            </form>
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
        <% } %>
        <form method="post" action="/blog/weibodo?param=addComm">
            <%="<input id=\"weic" + it.getId() + "\" type=\"hidden\" name=\"weiboc_id\" " + "value=\""+ it.getId()+"\">"%>
            <tr>
                <td><%="<input id=\"submit_" + it.getId() + "\" type=\"submit\" name=\"comm_id\" " + "value=\"评论\">"%></td>
                <td><textarea name="comment_text"></textarea></td>
            </tr>
        </form>
                        </tbody>
                    </table>
                </td>
            </tr>
    <% } %>
        </table>
    </body>
</html>
