package net.blog.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.blog.bean.*;
import net.blog.db.DbCon;
public class UserDao {
	public ArrayList<User> searchUsersByUser(String username) {
		ArrayList<User> ul = new ArrayList<User>();
		Connection con = DbCon.getDbConn();
		if (con != null) {
			try {
				Statement s = con.createStatement();
				String query = "select * from user where user_name like '%" + username+ "%'";
				System.out.print("searchUsersByUser ~> ");
				System.out.println(query);
				try{
					ResultSet rs =  s.executeQuery(query);
					try {
						while (rs.next()) {
							User u = new User();
							u.setName(rs.getString(1));
							u.setPassword(rs.getString(2));
							u.setEmail(rs.getString(3));
							u.setTel(rs.getString(4));
							u.setAge(rs.getInt(5));
							ul.add(u);
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
		return ul;
	}
	public ArrayList<Friend> searchFriendsByUser(String username) {
		ArrayList<Friend> fl = new ArrayList<Friend>();
		Connection con = DbCon.getDbConn();
		if (con != null) {
			try {
				Statement s = con.createStatement();
				String query = "select * from weibo.friend where f1_name = '" + username+ "'";
				System.out.print("searchFriendsByUser ~> ");
				System.out.println(query);
				try{
					ResultSet rs =  s.executeQuery(query);
					try {
						while (rs.next()) {
							Friend f = new Friend();
							f.setF1_name(rs.getString(1));
							f.setF2_name(rs.getString(2));
							f.setFriend_type(rs.getString(3));
							fl.add(f);
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
		return fl;
	}
}
