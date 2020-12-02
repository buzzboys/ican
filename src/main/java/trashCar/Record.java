package trashCar;

import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import trashCar.bean.TrashCarRecordBean;

@WebServlet("/car/record")
public class Record extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/trash?serverTimezone=UTC";
	private static final String USER = "root";
	private static final String PASSWORD = "Do!ng123";
	private static final String SQL = "SELECT * FROM trashcarrecord WHERE Name='Jacky'";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		 System.out.println(request.getParameter("lng") + ", " + request.getParameter("lat"));
//		 double WebLng =Double.parseDouble(request.getParameter("lng")) ;
//		 double WebLat =Double.parseDouble(request.getParameter("lat"));
//		 System.out.println(WebLng+ ", " + WebLat);

		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
			PreparedStatement stmt = conn.prepareStatement(SQL);
			ResultSet rs = stmt.executeQuery();
			TrashCarRecordBean trashcarrecord = null;

			while (rs.next()) {
				trashcarrecord = new TrashCarRecordBean();
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
				request.getRequestDispatcher("../car/setyes.jsp").forward(request, response);
			} else {
				request.setAttribute("trashcarrecord", trashcarrecord);
				request.getRequestDispatcher("../car/setno.jsp").forward(request, response);
			}
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Enumeration<String> pars = request.getParameterNames();
		while (pars.hasMoreElements()) {
			String param = pars.nextElement();
			String val = request.getParameter(param);
			System.out.println(param + ":" + val);

		}

		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM trashcarrecord WHERE Name='Jacky'");

			int del = pstmt.executeUpdate();
			if (del != 0) {
				System.out.println("成功");
			} else
				System.out.println("error");
			pstmt.close();
			PreparedStatement st = conn
					.prepareStatement("INSERT INTO trashcarrecord VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			st.setString(1, "Jacky");
			st.setString(2, request.getParameter("lng"));
			st.setString(3, request.getParameter("lat"));
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
			int in = st.executeUpdate();
			if (in != 0) {
				System.out.println("成功");
			} else
				System.out.println("error");
			st.close();
			doGet(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
