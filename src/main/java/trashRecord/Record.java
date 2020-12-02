package trashRecord;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import trashRecord.RNclass;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

@WebServlet("/trash/record")
public class Record extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MongoClient mongo = null;
		try {
			mongo = new MongoClient("localhost", 27017);
			MongoDatabase db = mongo.getDatabase("test");
			MongoCollection<Document> col = db.getCollection("Record");
			MongoCursor<Document> csr = col.find().cursor();
			long count_N = col.countDocuments();
			int i = 1;
			List<RNclass> Classes = new ArrayList<>();
			RNclass Class = null;

			while (csr.hasNext()) {
				Class = new RNclass();

				Document N = csr.next();
				String line_class = N.get("類別").toString();
				String line_date = N.get("時間").toString();
				String line = (i + " : " + line_class + "  " + line_date);
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
			request.getRequestDispatcher("./past.jsp").forward(request, response);

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
