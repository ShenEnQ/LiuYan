package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;

public class DB {
	public static   Connection getConnection(String db_user,String pass,String url)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//String url="jdbc:mysql://localhost:3306/message_board";
		//String name=getServletContext().getInitParameter("sql_user");
		//String password=getServletContext().getInitParameter("sql_password");
		//String url=getServletContext().getInitParameter("db_url");
		java.sql.Connection conn=null;
		try {
			conn=DriverManager.getConnection(url,db_user,pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	
}
