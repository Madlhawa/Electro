package blog.article1;

import java.awt.event.ItemListener;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gargoylesoftware.htmlunit.WebClient;
import com.gargoylesoftware.htmlunit.html.HtmlAnchor;
import com.gargoylesoftware.htmlunit.html.HtmlElement;
import com.gargoylesoftware.htmlunit.html.HtmlPage;

public class Ikman { 

	public static void main(String[] args) {
		
	for(int i=1;i<=20;i++)
	{
		
		
		
		String searchQuery = "iphone 6s" ;
		String baseUrl = "https://ikman.lk/en/ads" ;
		WebClient client = new WebClient();
		client.getOptions().setCssEnabled(false);
		client.getOptions().setJavaScriptEnabled(false);
		try {
			String searchUrl = baseUrl + "?query=" + URLEncoder.encode(searchQuery, "UTF-8")+"&page="+i;
			HtmlPage page = client.getPage(searchUrl);
			
			
			List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//div[@class='ui-item']") ;
			
			//System.out.println(page);
			
			//System.out.println(items);
			
			
		    if(items.isEmpty()){
				System.out.println("No items found !");
			}else{
				for(HtmlElement htmlItem : items){
					
					HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//div[@class='item-content']/a"));
					//HtmlElement name = ((HtmlElement) htmlItem.getFirstByXPath(".//a/span[@class='result-price']")) ;
					
					HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
					// It is possible that an item doesn't have any price, we set the price to 0.0 in this case
					//String itemPrice = price == null ? "0.0" : price.asText() ;
	
					HtmlElement itemlocation =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-area']"));
					
					HtmlElement itemcategory =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-cat']"));
					
				//	HtmlElement itemtimeuntillnow =((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='item-date']"));
							
					//item-date
					
					Item item = new Item();
					//item.setTitle(price.asText());
					item.setTitle(itemAnchor.asText());
				
					item.setLocation(itemlocation.asText());
					
					item.setPrice(price.asText());
					
					item.setcategory(itemcategory.asText());
					
					item.setUrl(baseUrl + itemAnchor.getHrefAttribute());
				
					//item.setTime(itemtimeuntillnow.asText());

					
				//	item.setPrice(new BigDecimal(itemPrice.replace("$", "")));
				
					
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
