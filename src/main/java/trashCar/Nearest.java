package trashCar;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import trashCar.bean.TrashCarBean;

class CompTrashcar implements Comparator<TrashCarBean> {
	private Double here_lat;
	private Double here_lng;

	CompTrashcar(double lat, double lng) {
		this.here_lat = lat;
		this.here_lng = lng;
	}

	@Override
	public int compare(TrashCarBean o1, TrashCarBean o2) {
		double distance1 = o1.getDistance(here_lat, here_lng);
		double distance2 = o2.getDistance(here_lat, here_lng);
		double diff = distance1 - distance2;

		int result;
		if (diff > 0)
			result = 1;
		else if (diff < 0)
			result = -1;
		else
			result = 0;
		return result;
	}

}

@WebServlet("/car/nearest")
public class Nearest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/trash?serverTimezone=UTC";
	private static final String USER = "root";
	private static final String PASSWORD = "Do!ng123";
	private static final String SQL = "SELECT * FROM trashcar";

	private List<TrashCarBean> getNearest3(List<TrashCarBean> trashcars) {
		List<TrashCarBean> nearest3 = new ArrayList<TrashCarBean>();

		nearest3.add(trashcars.get(0));
		nearest3.add(trashcars.get(1));
		nearest3.add(trashcars.get(2));
		return nearest3;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println(request.getParameter("lng") + ", " + request.getParameter("lat"));
		double WebLng = Double.parseDouble(request.getParameter("lng"));
		double WebLat = Double.parseDouble(request.getParameter("lat"));
		System.out.println(WebLng + ", " + WebLat);

		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
			PreparedStatement stmt = conn.prepareStatement(SQL);
			ResultSet rs = stmt.executeQuery();
			List<TrashCarBean> trashcars = new ArrayList<>();
			TrashCarBean trashcar = null;

			while (rs.next()) {
				trashcar = new TrashCarBean();
				trashcar.setCarTimeStart(rs.getString("CarTimeStart"));
				trashcar.setLng(rs.getString("Lng"));
				trashcar.setLat(rs.getString("Lat"));
				trashcars.add(trashcar);
			}

			trashcars.sort(new CompTrashcar(WebLat, WebLng));

			List<TrashCarBean> n3 = getNearest3(trashcars);
			System.out.println(n3);

			Gson gson = new Gson();
			String str = gson.toJson(n3);
			System.out.println(str);

			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			out.print(str);
			out.flush();
			request.setAttribute("trashcars", trashcars);

			stmt.close();

			// request.getRequestDispatcher("/trashCar/set.jsp").forward(request, response);
		} catch (SQLIntegrityConstraintViolationException e) {
			System.out.println("error");
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
		doGet(request, response);
	}

}
