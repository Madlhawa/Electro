package main.com.solrj;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.XMLResponseParser;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;

public class Test {

	public static void main(String[] args) throws IOException {
		String squery = "iphone 6s in colombo";
		
		System.out.println("\nConnecting to solr");
		String urlString = "http://104.154.242.107/solr/electro101";
		HttpSolrClient solr = new HttpSolrClient.Builder(urlString).build();
		solr.setParser(new XMLResponseParser());
		System.out.println("Done connecting");
		
		SolrQuery query = new SolrQuery();
		query.set("q", squery);
		query.set("df", "body");
		
		query.setFacet(true);
		query.addFacetField("store");
		query.addFacetField("condition");
		query.addFacetField("location");
		query.addFacetField("price");
		query.setGetFieldStatistics(true);
		query.addStatsFieldFacets("price");
		query.setParam("stats.field", "price"); 
		
		//setting highlights
		query.setHighlight(true).setHighlightSnippets(1);
		query.setParam("hl.fl", "title,description");
		query.setHighlightFragsize(0);
		query.setHighlightSimplePre("<b>");
		query.setHighlightSimplePost("</b>");
	 
		query.set("defType", "dismax"); 
		query.set("mm", 2); 
		
		System.out.println("\nGetting results from solr");
		QueryResponse res;
		try {
			res = solr.query(query);
			SolrDocumentList docList = res.getResults();
			FacetField storeField = (FacetField) res.getFacetField("store");
			FacetField conditionField = (FacetField) res.getFacetField("condition");
			FacetField locationField = (FacetField) res.getFacetField("location");
			FacetField priceField = (FacetField) res.getFacetField("price");
			Map<String, Map<String, List<String>>> highlights = res.getHighlighting();
			String title = highlights.get("c1275a1b-f7da-425c-a75a-e7c892c94a58").get("title").get(0);
			System.out.println(title);
			
			System.out.println(storeField);
			System.out.println(conditionField);
			System.out.println(locationField);
			System.out.println(priceField);
			System.out.println(res.getFacetField("id"));
			
			// assertEquals(docList.getNumFound(), 1);
			for (int i = 0; i < docList.size(); ++i) {
				SolrDocument doc = docList.get(i);
				System.out.println(doc.getFieldValue("title"));
				System.out.println(highlights.get(doc.getFieldValue("id")).get("title").get(0));
				if(doc.getFieldValue("description")!=null||doc.getFieldValue("id")!=null)
					System.out.println(highlights.get(doc.getFieldValue("id")).get("description"));
				System.out.println(doc.getFieldValue("id"));
			}
			
			double min = (double) res.getFieldStatsInfo().get("price").getMin();
			
			System.out.println(min);
			System.out.println(res.getFieldStatsInfo().get("price").getMax());
			
			
		} catch (SolrServerException e) {
			e.printStackTrace();
		}
	}

}
