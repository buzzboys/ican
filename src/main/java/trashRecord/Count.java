package trashRecord;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

@WebServlet("/Count")
public class Count extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MongoClient mongo = null;
		try {
			mongo = new MongoClient("localhost", 27017);
			MongoDatabase db = mongo.getDatabase("test");
			MongoCollection<Document> col = db.getCollection("Record");
			Document N = new Document("類別", "N");
			Document R = new Document("類別", "R");

			System.out.println(col.countDocuments(N));
			System.out.println(col.countDocuments(R));
//			long number_N = col.countDocuments(N);
//			long number_R = col.countDocuments(R);

			System.out.println("Connect to database successfully!");
//			
//			request.setAttribute("number_N", number_N);
//			request.setAttribute("number_N", number_R);			
//			request.getRequestDispatcher("/Ican/past.jsp").
//			forward(request, response);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if (mongo != null)
				mongo.close();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
