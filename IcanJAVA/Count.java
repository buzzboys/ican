package IcanJAVA;

import java.io.IOException;
import java.sql.*;
import java.util.Map;
import java.util.Set;

import javax.management.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.jdbc.pool.interceptor.SlowQueryReport.QueryStats;
import org.bson.Document;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoIterable;


@WebServlet("/Count")
public class Count extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String JDBC_DRIVER = "mongodb.jdbc.MongoDriver";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			MongoClient mongo = new MongoClient("localhost", 27017);
			MongoDatabase db = mongo.getDatabase("test"); 
			MongoCollection col = db.getCollection("Record");
			Document N = new Document("類別", "N");
			Document R = new Document("類別", "R"); 
			
			System.out.println(col.countDocuments(N));
			System.out.println(col.countDocuments(R));
			long number_N = col.countDocuments(N);
			long number_R = col.countDocuments(R);
			
			System.out.println("Connect to database successfully!");
//			
//			request.setAttribute("number_N", number_N);
//			request.setAttribute("number_N", number_R);			
//			request.getRequestDispatcher("/Ican/past.jsp").
//			forward(request, response);
			
		} catch (Exception e) {
			System.out.println(e);}
		}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}





