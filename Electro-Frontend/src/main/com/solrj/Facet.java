package main.com.solrj;

import java.io.IOException;

import java.util.Arrays;
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
 * Servlet implementation class Facet
 */
@WebServlet("/Facet")
public class Facet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Facet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get all the values from search.jsp
		String squery = request.getParameter("squery");
		String minPrice = request.getParameter("minPrice");
		String maxPrice = request.getParameter("maxPrice");
		String condition = request.getParameter("condition").split(" ")[0];
		String location = request.getParameter("location").split(" ")[0];
		List<String> storeList = null;
		String storeString = "*";
		String priceRange = "false";
		if(request.getParameter("pricerange")!=null)
			priceRange = request.getParameterValues("pricerange")[0];
		if(request.getParameter("store")!=null&&!request.getParameterValues("store")[0].contains("*")) {
			String [] stores = request.getParameterValues("store");
			storeList = Arrays.asList(stores);
			storeString = storeList.get(0).toString().split(" ")[0];
			for(int i =1;i<storeList.size();i++) {
				//storeList.set(i-1, storeList.get(i-1).split(" ")[0]);
				storeString = storeString.concat(","+storeList.get(i).split(" ")[0]);
			}
		}
		//print all the facet values
		System.out.println("\nNow running Facet.java");
		System.out.println("squery : "+squery);
		System.out.println("priceRange : "+priceRange);
		System.out.println("minPrice : "+minPrice);
		System.out.println("maxPrice : "+maxPrice);
		System.out.println("storeList : "+storeList);
		System.out.println("condition : "+condition);
		System.out.println("location : "+location);
		System.out.println("storeString : "+storeString);
		
		//connecting to solr
		//connecting to solr instance
		System.out.println("\nConnecting to solr");
		String urlString = "http://104.154.242.107/solr/electro";
		HttpSolrClient solr = new HttpSolrClient.Builder(urlString).build();
		solr.setParser(new XMLResponseParser());
		System.out.println("Done connecting");
				
		//setting the query
		SolrQuery query = new SolrQuery();
		query.set("q", squery);
		if((minPrice.isEmpty()&&maxPrice.isEmpty())||priceRange.equalsIgnoreCase("false"))
			query.set("fq", "condition:"+condition+" AND "+"store:"+storeString+" AND location:"+location);
		else if(minPrice.isEmpty())
			query.set("fq", "condition:"+condition+" AND "+"store:"+storeString+" AND location:"+location+" AND price:[* TO "+maxPrice+"]");
		else if(maxPrice.isEmpty())
			query.set("fq", "condition:"+condition+" AND "+"store:"+storeString+" AND location:"+location+" AND price:["+minPrice+" TO *]");
		else
			query.set("fq", "condition:"+condition+" AND "+"store:"+storeString+" AND location:"+location+" AND price:["+minPrice+" TO "+maxPrice+"]");
		
		query.set("df", "body");
		
		//setting facet query
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
		
		QueryResponse res;
		try {
			res = solr.query(query);
			SolrDocumentList docList = res.getResults();
			FacetField storeField = (FacetField) res.getFacetField("store");
			FacetField conditionField = (FacetField) res.getFacetField("condition");
			FacetField locationField = (FacetField) res.getFacetField("location");
			
			double minPriceF = 0;
			double maxPriceF = 0;
			Map<String, Map<String, List<String>>> highlights = null;
			if(res.getFieldStatsInfo().get("price").getCount()!=0) {
				minPriceF = (double) res.getFieldStatsInfo().get("price").getMin();
				maxPriceF = (double) res.getFieldStatsInfo().get("price").getMax();
				highlights = res.getHighlighting();
				request.setAttribute("results", true);
			}else
				request.setAttribute("results", false);
			
			for (int i = 0; i < docList.size(); ++i) {
				SolrDocument doc = docList.get(i);
				System.out.println(doc.getFieldValue("title"));
				System.out.println("\t"+doc.getFieldValue("condition"));
				System.out.println("\t"+doc.getFieldValue("store"));
				System.out.println("\t"+doc.getFieldValue("location"));
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
			request.setAttribute("minPrice", minPriceF);
			request.setAttribute("maxPrice", maxPriceF);
			request.setAttribute("highlights", highlights);
			if(request.getHeader("User-Agent").indexOf("Mobile") != -1) {
			    //you're in mobile land
				System.out.println("Device is : MOBILE");
				request.getRequestDispatcher("findMobile.jsp").forward(request, response);
			  } else {
			    //nope, this is probably a desktop
				  System.out.println("Device is : DEXTOP");
				request.getRequestDispatcher("find.jsp").forward(request, response);
			  }
			
		} catch (SolrServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
