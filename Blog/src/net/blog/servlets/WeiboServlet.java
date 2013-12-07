package net.blog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.blog.db.DbCon;

import java.sql.*;

public class WeiboServlet extends HttpServlet {
	private static final long serialVersionUID = 1234231L;
       
    public WeiboServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String param = request.getParameter("param");
		System.out.print("WeiboServlet param => ");
		System.out.println(param);
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("login_name");
		System.out.println("login_name => "+name);
		switch(param){
		case "addWeibo":
			int wid = 0;
			String login_name = (String) session.getAttribute("login_name");
			String text = request.getParameter("weibo_text");
			if (text.length() > 200) {
				text = "String too long";
			}
			Date date = new Date(new java.util.Date().getTime());
			Time time = new Time(new java.util.Date().getTime());
			System.out.print("weibo -> ");
			System.out.println(text);
			Connection con1 = DbCon.getDbConn();
			if (con1 != null) {
				try {
					Statement s1 = con1.createStatement();
					String max = "select max(weibo_id) from weibo.weibo;";
					String query = "";
					try{
							ResultSet rs1 = s1.executeQuery(max);
							if (rs1.next() && rs1.getString(1)!= null) {
								wid = Integer.parseInt(rs1.getString(1).trim());
								wid++;
								query = "insert into weibo.weibo(weibo_id, user_name, weibo_text, "
										+ "weibo_date, weibo_repost, weibo_visual) " 
										+ "values ("+ wid + ", '"  + login_name + "', '" + text + "', '"
										+ date.toString()+" "+time.toString() + "', 0, 1);" ;
							} else {
								query = "insert into weibo.weibo(weibo_id, user_name, weibo_text, "
										+ "weibo_date, weibo_repost, weibo_visual) " 
										+ "values ("+ "0" + ", '"  + login_name + "', '" + text + "', '"
										+ date.toString()+" "+time.toString() + "', 0, 1);" ;
							}
							System.out.print("Insert weibo ~> ");
							System.out.println(query);
							s1.executeUpdate(query);
							System.out.println("Insert weibo successfully");
							response.sendRedirect("userhome.jsp");
					}finally{ 
						s1.close(); 
					}
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println( e.getMessage());
				} finally{
					try {
						con1.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		case "delWeibo":
			String weibo_id = request.getParameter("weibo_id");
			System.out.print("delete weibo ~> ");
			System.out.println(weibo_id);
			Connection con = DbCon.getDbConn();
			if (con != null) {
				try {
					Statement s = con.createStatement();
					String query = "delete from weibo where weibo_id = " + weibo_id;
					try{
							System.out.print("Delete weibo ~> ");
							System.out.println(query);
							s.executeUpdate(query);
							response.sendRedirect("userhome.jsp");
					}finally{ 
						s.close(); 
					}
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println( e.getMessage());
				} finally{
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		case "addComm":
			int wid11 = 0;
			String login_name1 = (String) session.getAttribute("login_name");
			String weiboid = (String) request.getParameter("weiboc_id");
			String text1 = request.getParameter("comment_text");
			if (text1.length() > 200) {
				text1 = "String too long";
			}
			Date date1 = new Date(new java.util.Date().getTime());
			Time time1 = new Time(new java.util.Date().getTime());
			System.out.println("weiboid = >"+ weiboid);
			System.out.println("comment -> "+text1);
			Connection con11 = DbCon.getDbConn();
			if (con11 != null) {
				try {
					Statement s11 = con11.createStatement();
					String max = "select max(comm_id) from weibo.comm;";
					String query = "";
					try{
							ResultSet rs11 = s11.executeQuery(max);
							if (rs11.next() && rs11.getString(1)!= null) {
								wid11 = Integer.parseInt(rs11.getString(1).trim());
								wid11++;
								query = "insert into weibo.comm(comm_id, user_name, weibo_id, "
										+ "comm_text, comm_date) " 
										+ "values ("+ wid11 + ", '"  + login_name1 + "', '"+ weiboid 
										+ "', '" + text1 + "', '"
										+ date1.toString()+" "+time1.toString() + "');" ;
							} else {
								query = "insert into weibo.comm(comm_id, user_name, weibo_id, "
										+ "comm_text, comm_date) " 
										+ "values ("+ "0" + ", '"  + login_name1 + "', '"+ weiboid 
										+ "', '" + text1 + "', '"
										+ date1.toString()+" "+time1.toString() + "');" ;
							}
							System.out.print("Insert commo ~> ");
							System.out.println(query);
							s11.executeUpdate(query);
							System.out.println("Insert commo successfully");
							response.sendRedirect("userhome.jsp");
							
					}finally{ 
						s11.close(); 
					}
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println( e.getMessage());
				} finally{
					try {
						con11.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		case "addCommf":
			int wid111 = 0;
			String login_name11 = (String) session.getAttribute("login_name");
			String weiboid1 = (String) request.getParameter("weiboc_id");
			String text11 = request.getParameter("comment_text");
			if (text11.length() > 200) {
				text11 = "String too long";
			}
			Date date11 = new Date(new java.util.Date().getTime());
			Time time11 = new Time(new java.util.Date().getTime());
			System.out.println("weiboid = >"+ weiboid1);
			System.out.println("comment -> "+text11);
			Connection con111 = DbCon.getDbConn();
			if (con111 != null) {
				try {
					Statement s11 = con111.createStatement();
					String max = "select max(comm_id) from weibo.comm;";
					String query = "";
					try{
							ResultSet rs11 = s11.executeQuery(max);
							if (rs11.next() && rs11.getString(1)!= null) {
								wid111 = Integer.parseInt(rs11.getString(1).trim());
								wid111++;
								query = "insert into weibo.comm(comm_id, user_name, weibo_id, "
										+ "comm_text, comm_date) " 
										+ "values ("+ wid111 + ", '"  + login_name11 + "', '"+ weiboid1 
										+ "', '" + text11 + "', '"
										+ date11.toString()+" "+time11.toString() + "');" ;
							} else {
								query = "insert into weibo.comm(comm_id, user_name, weibo_id, "
										+ "comm_text, comm_date) " 
										+ "values ("+ "0" + ", '"  + login_name11 + "', '"+ weiboid1 
										+ "', '" + text11 + "', '"
										+ date11.toString()+" "+time11.toString() + "');" ;
							}
							System.out.print("Insert commo ~> ");
							System.out.println(query);
							s11.executeUpdate(query);
							System.out.println("Insert commo successfully");
							response.sendRedirect("friend_weibo.jsp");
							
					}finally{ 
						s11.close(); 
					}
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println( e.getMessage());
				} finally{
					try {
						con111.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			break;
		default:
			System.out.println("BUG;WeiboServlet");
		}
	}
}

