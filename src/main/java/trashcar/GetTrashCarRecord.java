package trashcar;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLSyntaxErrorException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import trashcar.bean.TrashCarBean;
import trashcar.bean.TrashCarRecordBean;


@WebServlet("/GetTrashCarRecord")
public class GetTrashCarRecord extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	private static final String JDBC_DRIVER = 
			"com.mysql.cj.jdbc.Driver";
	private static final String DB_URL = 
			"jdbc:mysql://localhost:3306/trash?serverTimezone=UTC";
	private static final String USER = "root";
	private static final String PASSWORD = "Do!ng123";
	private static final String SQL =
			"SELECT * FROM trashcarrecord WHERE Name='Jacky'";
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		 System.out.println(request.getParameter("lng") + ", " + request.getParameter("lat"));
//		 double WebLng =Double.parseDouble(request.getParameter("lng")) ;
//		 double WebLat =Double.parseDouble(request.getParameter("lat"));
//		 System.out.println(WebLng+ ", " + WebLat);


		 
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
			PreparedStatement stmt = conn.prepareStatement(SQL);
			ResultSet rs = stmt.executeQuery();
			TrashCarRecordBean trashcarrecord=null;

			while(rs.next()) {
				trashcarrecord=new TrashCarRecordBean();
				trashcarrecord.setName(rs.getString("Name"));
				trashcarrecord.setUserlat(rs.getString("Userlat"));
				trashcarrecord.setUserlng(rs.getString("Userlng"));
				trashcarrecord.setRelat1(rs.getString("Relat1"));
				trashcarrecord.setRelng1(rs.getString("Relng1"));
				trashcarrecord.setTime1(rs.getString("Time1"));
				trashcarrecord.setRelat2(rs.getString("Relat2"));
				trashcarrecord.setRelng2(rs.getString("Relng2"));
				trashcarrecord.setTime2(rs.getString("Time2"));
				trashcarrecord.setRelat3(rs.getString("Relat3"));
				trashcarrecord.setRelng3(rs.getString("Relng3"));
				trashcarrecord.setTime3(rs.getString("Time3"));
				trashcarrecord.setChoice(rs.getString("Choice"));
				
			}
			System.out.println(trashcarrecord);
			
			if (trashcarrecord == null) {
				request.getRequestDispatcher("/trashcar/setyes.jsp").forward(request, response);
			} else {
				request.setAttribute("trashcarrecord", trashcarrecord);
				request.getRequestDispatcher("/trashcar/setno.jsp").forward(request, response);	
			}
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (conn != null)
				try {
					conn.close();
				} catch(SQLException e) { 
					e.printStackTrace();
				}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
