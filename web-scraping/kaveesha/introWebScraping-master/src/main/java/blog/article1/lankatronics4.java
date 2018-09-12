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

public class lankatronics4 {  
	
   
    
	private static final String FILENAME = "D:\\data\\LankaTronicsMotor.json";

	public static void main(String[] args) {  
		
	for(int i=1;i<=5;i++)
	{
		//https://www.lankatronics.com/catalogsearch/result/index/?cat=&p=3&q=+arduino
		String searchQuery = "motor" ;
		String baseUrl = "https://www.lankatronics.com/" ;
		WebClient client = new WebClient();
		client.getOptions().setCssEnabled(false);
		client.getOptions().setJavaScriptEnabled(false);
		
		
		try {
			//https://www.lankatronics.com/catalogsearch/result/?cat=&q=+arduino
			//https://www.lankatronics.com/catalogsearch/result/index/?cat=&p=2&q=+arduino
			
			String searchUrl = baseUrl + "catalogsearch/result/index/?cat=&p=" +i+ "&q=+" + URLEncoder.encode(searchQuery, "UTF-8");
		//	String searchUrl = baseUrl +"?page="+i;
			HtmlPage page = client.getPage(searchUrl);		
			
			List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//li[@class='item product product-item']") ;
			
		//	System.out.println(page);
			
		//	System.out.println(items);
			
			
		    if(items.isEmpty())
		    {
				System.out.println("No items found !");
			}
		    else 
		    {
		    	
				for(HtmlElement htmlItem : items){
					
					HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//div[@class='box-image']/a"));
					
					HtmlElement title = ((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='product details product-item-details box-info']/h2")) ;
					
					HtmlElement itemAvailability =((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='stock unavailable']"));

					
					HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//span[@class='price']")) ;
							

					LankatronicItem item = new LankatronicItem();

					item.setTitle(title.asText());
				
					if(itemAvailability==null)
					{
						item.setAvailability("Available");
					
					}else {
						
						item.setAvailability(itemAvailability.asText());
					}
					
					if(price==null)
					{
						item.setPrice("00");
					
					}else {
						
						item.setPrice(price.asText());
					}
					
					
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
			System.out.println(e);
			
		}

	}
	}

}
