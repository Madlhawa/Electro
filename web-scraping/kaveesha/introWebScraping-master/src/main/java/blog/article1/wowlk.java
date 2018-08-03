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

public class wowlk { 

	public static void main(String[] args) {
		
	//for(int i=1;i<=20;i++)
	//{
		
		//phone and tabs
		
	//	String searchQuery = "iphone 6s" ;
		String baseUrl = "https://www.singhagiri.lk/item/list/tv" ;
		WebClient client = new WebClient();
		client.getOptions().setCssEnabled(false);
		client.getOptions().setJavaScriptEnabled(false);
		
		try {
			String searchUrl = baseUrl;
			HtmlPage page = client.getPage(searchUrl);		
			
			List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//ul[@class='row product-list grid']/li") ;
			
			System.out.println(page);
			
			System.out.println(items);
			
			
		    if(items.isEmpty()){
				System.out.println("No items found !");
			}else{
				for(HtmlElement htmlItem : items){
					
					HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//ul[@class='row product-list grid']/li/a"));
					//HtmlElement name = ((HtmlElement) htmlItem.getFirstByXPath(".//a/span[@class='result-price']")) ;
					
					HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
					// It is possible that an item doesn't have any price, we set the price to 0.0 in this case
					//String itemPrice = price == null ? "0.0" : price.asText() ;
	
					HtmlElement itemlocation =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-area']"));
					
					HtmlElement itemcategory =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-cat']"));
					
					HtmlElement itemdistance =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-meta']/span"));
							
					//item-date
					
					Item item = new Item();
					//item.setTitle(price.asText());
					//item.setTitle(itemAnchor.asText());
				
					//item.setLocation(itemlocation.asText());
					
					//item.setPrice(price.asText());
					
					//item.setcategory(itemcategory.asText());
					 
					item.setUrl(baseUrl + itemAnchor.getHrefAttribute());
					
			//		item.setDistance(itemdistance.asText());
				
					//item.setTime(itemtimeuntillnow.asText());

					
				//	item.setPrice(new BigDecimal(itemPrice.replace("$", "")));
				
					
					ObjectMapper mapper = new ObjectMapper();
					String jsonString = mapper.writeValueAsString(item) ;
					
				//	doc
					
					System.out.println(jsonString);
				}
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		
		
		
		
		/*
		
		try {String searchUrl = baseUrl;
		HtmlPage page = client.getPage(searchUrl);		
		
		List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//div[@class='col-lg-3 col-md-3 col-sm-4 col-xs-4 cat-products']") ;
		
		//System.out.println(page);
		
		//System.out.println(items);
		
		
		
	    if(items.isEmpty()){
			System.out.println("No items found !");
		}else{
			for(HtmlElement htmlItem : items){
				
				HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//div[@class='con-in']/a"));
				//HtmlElement name = ((HtmlElement) htmlItem.getFirstByXPath(".//a/span[@class='result-price']")) ;
				
				HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
				// It is possible that an item doesn't have any price, we set the price to 0.0 in this case
				//String itemPrice = price == null ? "0.0" : price.asText() ;

				HtmlElement itemlocation =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-area']"));
				
				HtmlElement itemcategory =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-cat']"));
				
				HtmlElement itemdistance =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-meta']/span"));
						
				//item-date
				
				Item item = new Item();
				//item.setTitle(price.asText());
				//item.setTitle(itemAnchor.asText());
			
				//item.setLocation(itemlocation.asText());
				
				//item.setPrice(price.asText());
				
				//item.setcategory(itemcategory.asText());
				 
				item.setUrl(baseUrl + itemAnchor.getHrefAttribute());
				
		//		item.setDistance(itemdistance.asText());
			
				//item.setTime(itemtimeuntillnow.asText());

				
			//	item.setPrice(new BigDecimal(itemPrice.replace("$", "")));
			
				
				ObjectMapper mapper = new ObjectMapper();
				String jsonString = mapper.writeValueAsString(item) ;
				
			//	doc
				
				System.out.println(jsonString);
			}
		}
		
	} catch(Exception e){
		e.printStackTrace();	
		}




*/
	}
	//}
	
	

	
	
	
	
	
}
