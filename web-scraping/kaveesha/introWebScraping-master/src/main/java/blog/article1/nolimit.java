package blog.article1;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gargoylesoftware.htmlunit.WebClient;
import com.gargoylesoftware.htmlunit.html.HtmlAnchor;
import com.gargoylesoftware.htmlunit.html.HtmlElement;
import com.gargoylesoftware.htmlunit.html.HtmlPage;

public class nolimit { 

	public static void main(String[] args) {
		
		for(int i=0;i<=15;i++)
		{
			
		//  String searchQuery = "iphone 6s" ;
			String baseUrl = "http://www.nolimit.lk/product-category/women/page/"+i+"/";
			
			WebClient client = new WebClient();
			client.getOptions().setCssEnabled(false);
			client.getOptions().setJavaScriptEnabled(false);
			try {
				//String searchUrl = baseUrl + "search/sss?sort=rel&query=" + URLEncoder.encode(searchQuery, "UTF-8");
				//HtmlPage page = client.getPage(searchUrl);
				
				HtmlPage page = client.getPage(baseUrl);
				
				List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//*[@id=\"content\"]/ul/li") ;  //list the this paths information
				
				//System.out.println(page.asXml());
				//System.out.println(items);
				
				if(items.isEmpty()){
					System.out.println("No items found !");
				}else{
					for(HtmlElement htmlItem : items){
					//	HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//p[@class='result-info']/a"));
					//	HtmlElement spanPrice = ((HtmlElement) htmlItem.getFirstByXPath(".//a/span[@class='result-price']")) ;

						HtmlElement itemAnchor = ((HtmlElement) htmlItem.getFirstByXPath(".//a/h3"));
						//HtmlElement spanPrice = ((HtmlElement) htmlItem.getFirstByXPath(".//a/span[@class='result-price']")) ;
						
						
						//System.out.println(itemAnchor.asText());
						
						// It is possible that an item doesn't have any price, we set the price to 0.0 in this case
						//String itemPrice = spanPrice == null ? "0.0" : spanPrice.asText() ;
						
						Item item = new Item();
						item.setTitle(itemAnchor.asText());
						//item.setUrl( baseUrl + itemAnchor.getHrefAttribute());
						
						//item.setPrice(new BigDecimal(itemPrice.replace("$", "")));
					
						
						ObjectMapper mapper = new ObjectMapper();
						String jsonString = mapper.writeValueAsString(item) ;
						
						System.out.println(jsonString);
						
						
						
					}
				}
				
			} catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		
	  

	}

}
