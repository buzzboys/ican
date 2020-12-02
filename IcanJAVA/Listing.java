package IcanJAVA;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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

import IcanJAVA.RNclass;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoIterable;


@WebServlet("/Listing")
public class Listing extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String JDBC_DRIVER = "mongodb.jdbc.MongoDriver";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			MongoClient mongo = new MongoClient("localhost", 27017);
			MongoDatabase db = mongo.getDatabase("test"); 
			MongoCollection col = db.getCollection("Record");
			MongoCursor<Document> csr = col.find().cursor();
			long count_N = col.countDocuments();
			int i = 1;
			List<RNclass> Classes = new ArrayList<>();
			RNclass Class = null;

			while (csr.hasNext()) {	
				Class = new RNclass();
				
				Document N =csr.next();
				String line_class = N.get("類別").toString();
				String line_date  = N.get("時間").toString();	
				String line = (i+" : "+line_class+"  "+line_date);
				i++;
				
				Class.setTime(N.get("時間").toString());
				Class.setRN_class(N.get("類別").toString());
				Classes.add(Class);
				
				System.out.println(line);
			}
			System.out.println(count_N);
			System.out.println("Connect to database successfully!");
//			
			request.setAttribute("Classes", Classes);
			request.getRequestDispatcher("/Ican/past.jsp").
			forward(request, response);
			
		} catch (Exception e) {
			System.out.println(e);}
		}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}





