package trashRecord;

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

import org.bson.Document;

import trashRecord.RNclass;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoIterable;


@WebServlet("/trash/record")
public class Record extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			MongoClient mongo = new MongoClient("localhost", 27017);
			MongoDatabase db = mongo.getDatabase("test"); 
			MongoCollection col = db.getCollection("past");
			
			//change page
//			long total = ((DBCollection) col.find()).count();
//			int page_size = 10;
//			int page_num = 0;
//			int skips = page_size * (page_num - 1);
//			
			// Skip and limit
//			MongoCursor<Document> csr = col.find().skip(skips).limit(page_size).cursor();

			// Return documents
				        
			MongoCursor<Document> csr = col.find().cursor();
			
			Document N = new Document("type", "normal");
			Document R = new Document("type", "recycle");
			Document cn = new Document("class", "normal");
			Document cb = new Document("class", "bottle");
			Document cc = new Document("class", "can");
			Document cp = new Document("class", "papper");
			Document cba = new Document("class", "battery");

			long number_N = col.countDocuments(N);
			long number_R = col.countDocuments(R);
			long number_cn = col.countDocuments(cn);
			long number_cb = col.countDocuments(cb);
			long number_cc = col.countDocuments(cc);
			long number_cp = col.countDocuments(cp);
			long number_cba = col.countDocuments(cba);
			
			
			int i = 1;
			List<RNclass> Classes = new ArrayList<>();
			RNclass Class = null;

			while (csr.hasNext()) {	
				Class = new RNclass();
				
				Document Nl =csr.next();
				String line_class = Nl.get("type").toString();
				String line_date  = Nl.get("time").toString();
				String line_type  = Nl.get("class").toString();
				String line = (i+" : "+line_class+"  "+line_date+"  "+line_type);
				i++;
				
				Class.setTime(Nl.get("time").toString());
				Class.setRN_class(Nl.get("type").toString());
				Class.setType(Nl.get("class").toString());
				
				Classes.add(Class);
				
				System.out.println(line);
			}
			System.out.println(number_N);
			System.out.println(number_R);
			System.out.println("Connect to database successfully!");
			request.setAttribute("number_N", number_N);
			request.setAttribute("number_R", number_R);
			request.setAttribute("number_cn", number_cn);
			request.setAttribute("number_cb", number_cb);
			request.setAttribute("number_cc", number_cc);
			request.setAttribute("number_cp", number_cp);
			request.setAttribute("number_cba", number_cba);
			request.setAttribute("Classes", Classes);
			request.getRequestDispatcher("./past.jsp").
			forward(request, response);
			
		} catch (Exception e) {
			System.out.println(e);}
		}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}





