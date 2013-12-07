package net.blog.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.blog.db.DbCon;


public class DiaryServlet extends HttpServlet {
	private static final long serialVersionUID = 2354245241L;

    public DiaryServlet() {
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
		System.out.print("DiaryServlet param => ");
		System.out.println(param);
		HttpSession session = request.getSession();
		switch (param) {
		case "addDiary":
			int did = 0;
			String login_name = (String) session.getAttribute("login_name");
			String text = request.getParameter("diary_text");
			String title = request.getParameter("diary_title");
			Date date = new Date(new java.util.Date().getTime());
			Time time = new Time(new java.util.Date().getTime());
			System.out.println("title -> "+title);
			System.out.println("diary -> "+text);
			Connection con1 = DbCon.getDbConn();
			if (con1 != null) {
				try {
					Statement s1 = con1.createStatement();
					String max = "select max(diary_id) from weibo.diary;";
					String query = "";
					try{
							ResultSet rs1 = s1.executeQuery(max);
							if (rs1.next() && rs1.getString(1)!= null) {
								did = Integer.parseInt(rs1.getString(1).trim());
								did++;
								query = "insert into weibo.diary(diary_id, user_name, diary_title, "
										+ "diary_text, diary_date, diary_repost, diary_visual) " 
										+ "values ("+ did + ", '"  + login_name + "', '" + title + "', '" +
										text + "', '"	+ date.toString()+" "+time.toString() + "', 0, 1);" ;
							} else {
								query = "insert into weibo.diary(diary_id, user_name, diary_title, "
										+ "diary_text, diary_date, diary_repost, diary_visual) " 
										+ "values ("+ "0" + ", '"  + login_name + "', '" + title + "', '" +
										text + "', '"	+ date.toString()+" "+time.toString() + "', 0, 1);" ;
							}
							System.out.print("Insert diary ~> ");
							System.out.println(query);
							s1.executeUpdate(query);
							System.out.println("Insert diary successfully");
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
		case "listDiary":
			String username = (String) session.getAttribute("login_name");
			System.out.print("user name => ");
			System.out.println(username);
			response.sendRedirect("list_diary.jsp");
			break;
		case "delDiary":
			String diary_id = request.getParameter("diary_id");
			System.out.print("delete Diary ~> ");
			System.out.println(diary_id);
			Connection con = DbCon.getDbConn();
			if (con != null) {
				try {
					Statement s = con.createStatement();
					String query = "delete from weibo.diary where diary_id = " + diary_id;
					try{
							System.out.print("Delete weibo ~> ");
							System.out.println(query);
							s.executeUpdate(query);
							response.sendRedirect("list_diary.jsp");
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
			default:
				System.out.println("BUG;DiaryServlet");
		}
	}

}
