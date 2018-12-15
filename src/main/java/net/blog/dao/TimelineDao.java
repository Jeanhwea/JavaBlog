package net.blog.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import net.blog.bean.Timeline;
import net.blog.db.DbCon;

public class TimelineDao {
  public ArrayList<Timeline> getTimelineByUser(String username) {
    ArrayList<Timeline> tl = new ArrayList<Timeline>();
    Connection con = DbCon.getDbConn();
    if (con != null) {
      try {
        Statement s = con.createStatement();
        String query =
            "select * from timeline where user_name = '" + username + "' order by tline_id";
        System.out.print("getTimelineByUser ~> ");
        System.out.println(query);
        try {
          ResultSet rs = s.executeQuery(query);
          try {
            while (rs.next()) {
              Timeline t = new Timeline();
              t.setId(rs.getString(1));
              t.setUser_name(rs.getString(2));
              t.setTline_time(rs.getString(3));
              t.setTline_action(rs.getString(4));
              tl.add(t);
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
    return tl;
  }
}
