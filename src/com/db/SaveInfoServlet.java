package com.db;

import java.io.IOException;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.model.DB;


/**
 * Servlet implementation class SaveInfoServlet
 */
public class SaveInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveInfoServlet() {
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
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session=request.getSession();
		String username=(String) session.getAttribute("username");
		String mail=(String) session.getAttribute("mail");
		String info_id=request.getParameter("info_id");
		String areaText=request.getParameter("info");
		String time=request.getParameter("time");
		String ip=getIp(request);
		//System.out.println("id "+info_id+"; username "+username+"; ip "+ip+"; mail  "+mail+"; info   "+areaText);
		
		//数据过滤
		areaText=this.htmlFilter(areaText);
		
		
		
		String url=getServletContext().getInitParameter("db_url");
		Connection conn=DB.getConnection(getServletContext().getInitParameter("db_username"), 
				getServletContext().getInitParameter("db_pass"),url);
		
		PreparedStatement statement=null;
		try {
			statement= conn.prepareStatement("insert into message_info values(?,?,?,?,?,?)");
			statement.setString(1, info_id);
			statement.setString(2, username);
			statement.setString(3, mail);
			statement.setString(4, ip);
			statement.setString(5, time);
			statement.setString(6, areaText);
			statement.executeUpdate();
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
	}
	
	
	
	public String getIp(HttpServletRequest request){
		if (request.getHeader("x-forwarded-for") == null)
			return request.getRemoteAddr();
		else
			return request.getRemoteAddr();
			
	}
	//过滤html提交过来的script脚本
	 public  String htmlFilter(String message) {

	        if (message == null)
	            return (null);

	        char content[] = new char[message.length()];
	        message.getChars(0, message.length(), content, 0);
	        StringBuilder result = new StringBuilder(content.length + 50);
	        for (int i = 0; i < content.length; i++) {
	            switch (content[i]) {
	            case '<':
	                result.append("&lt;");
	                break;
	            case '>':
	                result.append("&gt;");
	                break;
	            case '&':
	                result.append("&amp;");
	                break;
	            case '"':
	                result.append("&quot;");
	                break;
	            default:
	                result.append(content[i]);
	            }
	        }
	        return (result.toString());

	    }
	
}
