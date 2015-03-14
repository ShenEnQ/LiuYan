package com.ajax;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.model.DB;

/**
 * Servlet implementation class PageServerServlet
 */
public class PageServerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PageServerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=gbk");
		int page=Integer.parseInt(request.getParameter("page"));//ÇëÇóµÄ
		int len=Integer.parseInt(request.getParameter("len"));
		//System.out.println(page+", len:"+len);
		
		String db_url=getServletContext().getInitParameter("db_url"); 
		Connection conn= DB.getConnection(getServletContext().getInitParameter("db_username"),
				getServletContext().getInitParameter("db_pass"),db_url);
		PreparedStatement statement=null;
		BufferedWriter bout=new BufferedWriter(new OutputStreamWriter(response.getOutputStream()));
		try {
			statement=conn.prepareStatement("SELECT id,username,time,msg from message_info ORDER BY id+0 desc limit ?,?;");
			statement.setInt(1, len*(page-1));
			statement.setInt(2, len);
			ResultSet resultSet=statement.executeQuery();
			String id,username,time,msg;
			
			JSONArray jsonArray=new JSONArray();
			while(resultSet.next())
			{
				id=resultSet.getString(1);
				username=resultSet.getString(2);
				time=resultSet.getString(3);
				msg=resultSet.getString(4);
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("info_id", id);
				jsonObject.put("username", username);
				jsonObject.put("time", time);
				jsonObject.put("msg", msg);
				
				jsonArray.put(jsonObject);
				
			}
			JSONObject resJosn=new JSONObject();
			resJosn.put("info", jsonArray);
			//System.out.println(resJosn.toString());
			
			
			bout.write(resJosn.toString());
		} catch (Exception e) {
			// TODO: handle exception
		}
		try {
			bout.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
