package trashcar;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.stream.JsonReader;

import trashcar.bean.TrashCarBean;



@WebServlet("/GetCarsToDB")
public class GetCarsToDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	private static final String JDBC_DRIVER = 
			"com.mysql.cj.jdbc.Driver";
	private static final String DB_URL = 
			"jdbc:mysql://localhost:3306/trash?serverTimezone=UTC";
	private static final String USER = "root";
	private static final String PASSWORD = "Do!ng123";
	private static final String SQL =
			"SELECT * FROM trashcar";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Enumeration<String> pars = request.getParameterNames();
		while(pars.hasMoreElements()) {
			String param=pars.nextElement();
			String val=request.getParameter(param);
			System.out.println(param+":"+val);			
			
		}
		

		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
			PreparedStatement pstmt=conn.prepareStatement("DELETE FROM trashcarrecord WHERE Name='Jacky'");
			
			int del = pstmt.executeUpdate();
			if (del != 0) {
				System.out.println("成功");
			} else
				System.out.println("error");
			pstmt.close();
			PreparedStatement st= conn.prepareStatement("INSERT INTO trashcarrecord VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			st.setString(1,"Jacky");
			st.setString(2,request.getParameter("lng"));
			st.setString(3,request.getParameter("lat"));
			st.setString(4, request.getParameter("Lng1"));
			st.setString(5, request.getParameter("Lat1"));
			st.setString(6, request.getParameter("CarTimeStart1"));
			st.setString(7, request.getParameter("Lng2"));
			st.setString(8, request.getParameter("Lat2"));
			st.setString(9, request.getParameter("CarTimeStart2"));
			st.setString(10, request.getParameter("Lng3"));
			st.setString(11, request.getParameter("Lat3"));
			st.setString(12, request.getParameter("CarTimeStart3"));
			st.setString(13, request.getParameter("gt"));
			int in=st.executeUpdate();
			if (in != 0) {
				System.out.println("成功");
			} else
				System.out.println("error");
			st.close();
			request.getRequestDispatcher("./GetTrashCarRecord").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
