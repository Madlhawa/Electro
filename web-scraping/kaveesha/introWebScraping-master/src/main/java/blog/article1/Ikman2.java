package blog.article1;

import java.awt.event.ItemListener;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gargoylesoftware.htmlunit.WebClient;
import com.gargoylesoftware.htmlunit.html.HtmlAnchor;
import com.gargoylesoftware.htmlunit.html.HtmlElement;
import com.gargoylesoftware.htmlunit.html.HtmlPage;

public class Ikman2 { 
	
	
	private static final String FILENAME = "D:\\data\\Ikman.json";

	public static void main(String[] args) {
		
	for(int i=1;i<=20;i++)
	{
		
		
		String baseUrl = "https://ikman.lk/en/ads/sri-lanka/electronics" ;
		WebClient client = new WebClient();
		client.getOptions().setCssEnabled(false);
		client.getOptions().setJavaScriptEnabled(false);
		
		
		try {
			
			
			String searchUrl = baseUrl +"?page="+i;
			HtmlPage page = client.getPage(searchUrl);		
			
			List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//div[@class='ui-item']") ;
			
			//System.out.println(page);
			
			//System.out.println(items);
			
			
		    if(items.isEmpty())
		    {
				System.out.println("No items found !");
			}
		    else
		    {
		    	
				for(HtmlElement htmlItem : items){
					
					HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//div[@class='item-content']/a"));
					
					HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
			
					
	
					HtmlElement itemlocation =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-area']"));
					
					HtmlElement itemcategory =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-location']/span[@class='item-cat']"));
					
					HtmlElement itemdistance =((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-meta']/span"));
							
					
					
					Item item = new Item();

					item.setTitle(itemAnchor.asText());
				
					item.setLocation(itemlocation.asText());
					
					//item.setPrice(price.asText());
					
					if(price==null)
					{
						item.setPrice("00");
					
					}else {
						
						item.setPrice(price.asText());
					}
					
					item.setcategory(itemcategory.asText());
					
					item.setUrl(baseUrl + itemAnchor.getHrefAttribute());
					
				
					
					ObjectMapper mapper = new ObjectMapper();
					String jsonString = mapper.writeValueAsString(item) ;
					
					System.out.println(jsonString);
					
	

					FileWriter fw = new FileWriter(FILENAME, true);
					BufferedWriter bw = new BufferedWriter(fw);

					
					try {

						String content = jsonString + System.lineSeparator();
						bw.write(content);

					} catch (IOException e) {

						e.printStackTrace();

					} finally {

						try {

							if (bw != null)
								bw.close();


						} catch (IOException ex) {

							ex.printStackTrace();

						}

					}

				
					
					
					
					
					
				}
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}

	}
	}

}
