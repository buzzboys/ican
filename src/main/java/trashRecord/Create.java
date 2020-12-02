package trashRecord;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

@WebServlet("/Create")
public class Create extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MongoClient mongo = null;
		try {
			mongo = new MongoClient("localhost", 27017);
			MongoDatabase db = mongo.getDatabase("test");
			MongoCollection<Document> col = db.getCollection("Record");

			Date D = new Date();
			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String strDate = sdFormat.format(D);

			Document document_new = new Document();
			document_new.append("類別", "R");
			document_new.append("時間", strDate);

			col.insertOne(document_new);

			System.out.println(strDate);
			System.out.println("Connect to database successfully!");
//			
//			request.setAttribute("number", number);
//			request.getRequestDispatcher("/Ican/past.jsp").
//			forward(request, response);

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if (mongo != null) {
				mongo.close();				
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
