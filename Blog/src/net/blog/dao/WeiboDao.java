package net.blog.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.blog.db.*;
import net.blog.bean.*;
public class WeiboDao {
	public ArrayList<Weibo> getWeiboByUser(String username) {
		ArrayList<Weibo> wl = new ArrayList<Weibo>();
		Connection con = DbCon.getDbConn();
		if (con != null) {
			try {
				Statement s = con.createStatement();
				String query = "select * from weibo where user_name = '" + username+ "' order by weibo_id desc";
				System.out.print("getWeiboByUser ~> ");
				System.out.println(query);
				try{
					ResultSet rs =  s.executeQuery(query);
					try {
						while (rs.next()) {
							Weibo w = new Weibo();
							w.setId(rs.getString(1));
							w.setUser_name(rs.getString(2));
							w.setText(rs.getString(3));
							w.setDate(rs.getString(4));
							w.setRepost(Integer.parseInt(rs.getString(5)));
							wl.add(w);
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
		return wl;
	}
}
