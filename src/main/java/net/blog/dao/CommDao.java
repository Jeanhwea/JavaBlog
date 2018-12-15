package net.blog.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import net.blog.bean.*;
import net.blog.db.*;

public class CommDao {
  public ArrayList<Comm> getCommByWeibo(int weibo_id) {
    ArrayList<Comm> cl = new ArrayList<Comm>();
    Connection con = DbCon.getDbConn();
    if (con != null) {
      try {
        Statement s = con.createStatement();
        String query = "select * from comm where weibo_id = '" + weibo_id + "' order by comm_id";
        System.out.print("getCommByWeibo ~> ");
        System.out.println(query);
        try {
          ResultSet rs = s.executeQuery(query);
          try {
            while (rs.next()) {
              Comm c = new Comm();
              c.setId(rs.getString(1));
              c.setName(rs.getString(2));
              c.setId(rs.getString(3));
              c.setText(rs.getString(4));
              c.setDate(rs.getString(5));
              cl.add(c);
            }
          } finally {
            rs.close();
          }
        } finally {
          s.close();
        }
      } catch (SQLException e) {
        e.printStackTrace();
        System.out.println(e.getMessage());
      } finally {
        try {
          con.close();
        } catch (SQLException e) {
          e.printStackTrace();
        }
      }
    }
    return cl;
  }
}
