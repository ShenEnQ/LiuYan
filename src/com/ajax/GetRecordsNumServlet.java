package com.ajax;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.DB;

/**
 * Servlet implementation class GetRecordsNumServlet
 */
public class GetRecordsNumServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetRecordsNumServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		String db_url=getServletContext().getInitParameter("db_url");
		Connection conn=DB.getConnection(getServletContext().getInitParameter("db_username"),
				getServletContext().getInitParameter("db_pass"),db_url);
		PreparedStatement statement=null;
		int count=0;
		try {
			statement= conn.prepareStatement("SELECT count(*) from message_info;");
			ResultSet resultSet= statement.executeQuery();
			
			if(resultSet.next())
			{
				count=resultSet.getInt(1);
			}
				
			//System.out.println("ÁôÑÔ°å¼ÇÂ¼×ÜÊý£º"+count);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		OutputStreamWriter out=new OutputStreamWriter(response.getOutputStream());
		out.write(count+"");
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
