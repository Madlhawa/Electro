package main.com.solrj;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.XMLResponseParser;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;

public class edismaxTest {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		String squery = "gaming keyboard";
		
		System.out.println("\nConnecting to solr");
		String urlString = "http://104.154.242.107/solr/electro101";
		HttpSolrClient solr = new HttpSolrClient.Builder(urlString).build();
		solr.setParser(new XMLResponseParser());
		System.out.println("Done connecting");
		
		SolrQuery query = new SolrQuery();
		query.set("q", squery);
		query.set("df", "body");
		
		query.set("defType", "edismax"); 
		query.set("mm", 2);
		
		System.out.println("\nGetting results from solr");
		QueryResponse res;
		try {
			res = solr.query(query);
			SolrDocumentList docList = res.getResults();
			
			for (int i = 0; i < docList.size(); ++i) {
				SolrDocument doc = docList.get(i);
				System.out.println(doc.getFieldValue("title"));
				
			}
		} catch (SolrServerException e) {
			e.printStackTrace();
		}
	}

}
