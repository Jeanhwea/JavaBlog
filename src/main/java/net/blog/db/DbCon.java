package net.blog.db;

import java.sql.Connection;
import java.sql.DriverManager;


public class DbCon {

  public static Connection getDbConn() {
    Connection con = null;
    String CLASSFORNAME = "com.mysql.jdbc.Driver";
    String SERVANDDB = "jdbc:mysql://localhost:3306/weibo";
    String USER = "root";
    String PWD = "19921104";
    String url =
        SERVANDDB
            + "?user="
            + USER
            + "&password="
            + PWD
            + "&useUnicode=true&characterEncoding=UTF-8";
    System.out.println("url = > " + url);

    try {
      Class.forName(CLASSFORNAME).newInstance();
      con = DriverManager.getConnection(url);
    } catch (Exception e) {
      e.printStackTrace();
    }

    return con;
  }

}
