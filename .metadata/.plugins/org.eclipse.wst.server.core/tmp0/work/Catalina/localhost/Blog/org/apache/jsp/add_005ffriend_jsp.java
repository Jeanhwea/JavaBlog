/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.42
 * Generated at: 2013-12-07 16:59:41 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import net.blog.bean.User;
import java.util.ArrayList;
import java.util.Iterator;
import net.blog.db.DbCon;

public final class add_005ffriend_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
 
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

      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<title>Add friend</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<table>\r\n");
      out.write("\t<tr><td><p><a href=\"userhome.jsp\">HOME</a></p></td></tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table>\r\n");
      out.write("\t<form id=\"add_friend\" method=\"post\" action=\"/Blog/userdo?param=searchFriend\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td>输入好友昵称：</td>\r\n");
      out.write("\t\t\t\t<td> <input id=\"friend_name\" type=\"text\" name=\"friend_name\"> </td>\r\n");
      out.write("\t\t\t\t<td> <input id=\"add\" type=\"submit\" value=\"查找\"></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t</form>\r\n");
      out.write("</table>\r\n");
 
	ArrayList<User> ul = (ArrayList<User>) session.getAttribute("friendlist");
	boolean find = false;
	if (ul != null) {
		Iterator<User> its = ul.iterator();
		while (its.hasNext()) {
			User it = its.next();
			find = true;

      out.write("\r\n");
      out.write("\t<form method=\"post\" action=\"/Blog/userdo?param=linkFriend\">\r\n");
      out.write("\t\t<table>\r\n");
      out.write("\t\t");
      out.print("<input id=\"friend_" + it.getName() + "\" type=\"hidden\" name=\"f2name\" " + "value=\"" + it.getName()+"\">");
      out.write("\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>");
      out.print("<input id=\"add_" + it.getName() + "\" type=\"submit\" " + "value=\"添加好友\">");
      out.write("</td>\r\n");
      out.write("\t\t<td>");
      out.print(" ---> "+it.getName() );
      out.write("</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<hr/>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t</form>\r\n");
		} 
      out.write('\r');
      out.write('\n');
  } 
      out.write("\r\n");
      out.write("<table><hr/></table>\r\n");
 
	if (find == false && ul != null) {

      out.write("<table><strong>未找到与该用户名相关的用户</strong></table>\r\n");
      out.write("\t<table><hr/></table>\r\n");
}
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
