package net.blog.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.blog.bean.Diary;
import net.blog.db.DbCon;

public class DiaryDao {
	public ArrayList<Diary> getDiaryByUser(String username) {
		ArrayList<Diary> dl = new ArrayList<Diary>();
		Connection con = DbCon.getDbConn();
		if (con != null) {
			try {
				Statement s = con.createStatement();
				String query = "select * from weibo.diary where user_name = '" + username
						+ "' order by diary_id desc";
				System.out.print("getDiaryByUser ~> ");
				System.out.println(query);
				try{
					ResultSet rs =  s.executeQuery(query);
					try {
						while (rs.next()) {
							Diary d = new Diary();
							d.setId(rs.getString(1));
							d.setName(rs.getString(2));
							d.setTitle(rs.getString(3));
							d.setText(rs.getString(4));
							d.setDate(rs.getString(5));
							d.setRepost(Boolean.parseBoolean(rs.getString(6)));
							d.setVisual(Boolean.parseBoolean(rs.getString(7)));
							dl.add(d);
						}
					} finally {
						rs.close();
					}
				}finally{ 
					s.close(); 
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			} finally{
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return dl;
	}
}
