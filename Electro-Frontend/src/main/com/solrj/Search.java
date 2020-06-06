package main.com.solrj;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.XMLResponseParser;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Search() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//saving received parameters to variables
		String squery = request.getParameter("squery");
		String store = request.getParameter("store");
		String condition = request.getParameter("condition");
		System.out.println("Receiving parameters...");
		System.out.println(squery+" - "+store+" - "+condition);
		
		//connecting to solr instance
		System.out.println("\nConnecting to solr");
		String urlString = "http://104.154.242.107/solr/electro";
		HttpSolrClient solr = new HttpSolrClient.Builder(urlString).build();
		solr.setParser(new XMLResponseParser());
		System.out.println("Done connecting");
		
		//excecuting solr query
		System.out.println("\nExecuting solr query..");
		SolrQuery query = new SolrQuery();
		query.set("q", squery);
		if(condition!=null||store!=null)
			query.set("fq", "condition:"+condition+" AND "+"store:"+store);
		query.set("df", "body");
		query.setFacet(true);
		query.addFacetField("store");
		query.addFacetField("condition");
		query.addFacetField("location");
		query.setGetFieldStatistics(true);
		query.addStatsFieldFacets("price");
		query.setParam("stats.field", "price"); 
		
		//setting highlights
		query.setHighlight(true).setHighlightSnippets(1);
		query.setParam("hl.fl", "title,body");
		query.setHighlightFragsize(0);
		query.setHighlightSimplePre("<b>");
		query.setHighlightSimplePost("</b>");
		
		//edimax
		query.set("defType", "edismax"); 
		query.set("mm", 2);

		System.out.println("\nGetting results from solr");
		QueryResponse res;
		try {
			res = solr.query(query);
			SolrDocumentList docList = res.getResults();
			FacetField storeField = (FacetField) res.getFacetField("store");
			FacetField conditionField = (FacetField) res.getFacetField("condition");
			FacetField locationField = (FacetField) res.getFacetField("location");
			
			double minPrice = 0;
			double maxPrice = 0;
			Map<String, Map<String, List<String>>> highlights = null;
			if(res.getFieldStatsInfo().get("price").getCount()!=0) {
				minPrice = (double) res.getFieldStatsInfo().get("price").getMin();
				maxPrice = (double) res.getFieldStatsInfo().get("price").getMax();
				highlights = res.getHighlighting();
				request.setAttribute("results", true);
			}else
				request.setAttribute("results", false);
			
			for (int i = 0; i < docList.size(); ++i) {
				SolrDocument doc = docList.get(i);
				System.out.println(doc.getFieldValue("title"));
			}

			System.out.println("squery : "+squery);
			System.out.println("storeField : "+storeField.getValues());
			System.out.println("conditionField : "+conditionField.getValues());
			System.out.println("locationField : "+locationField.getValues());
			System.out.println(storeField.getValueCount());
			
			System.out.println("\nSending values back to search.jsp");
			request.setAttribute("userQuery", squery);
			request.setAttribute("docList", docList);
			request.setAttribute("storeField", storeField);
			request.setAttribute("conditionField", conditionField);
			request.setAttribute("locationField", locationField);
			request.setAttribute("minPrice", minPrice);
			request.setAttribute("maxPrice", maxPrice);
			request.setAttribute("highlights", highlights);
			request.getRequestDispatcher("search.jsp").forward(request, response);
			
		} catch (SolrServerException e) {
			e.printStackTrace();
		}
	}

}
