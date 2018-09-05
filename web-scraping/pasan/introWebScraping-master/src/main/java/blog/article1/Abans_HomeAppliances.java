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

public class Abans_HomeAppliances { 
	
	
	//private static final String FILENAME = "C:\\Users\\jajja\\Desktop\\data\\Abans(BuyBans)\\Home_Appliances.json";

	public static void main(String[] args) {
		
	
		for(int i=1;i<=7;i++)
		{
		
		
		String baseUrl = "https://buyabans.com/item/list/home-appliances" ;
		WebClient client = new WebClient();
		client.getOptions().setCssEnabled(false);
		client.getOptions().setJavaScriptEnabled(false);
		
		
		try {
			
			
			String searchUrl = baseUrl+"?page="+i;
			HtmlPage page = client.getPage(searchUrl);		
			
			List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//ul[@id='filter-container']");
			
			//System.out.println(page);
			
			//System.out.println(items);
			
	
			
		    if(items.isEmpty())
		   {
				System.out.println("No items found !");
			}
		    else
		    {
		    	
				for(HtmlElement htmlItem : items){
					
			     //   HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//li[@class='productbox-cat mix brand-23']/a"));
					HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//li/a"));
			        HtmlElement itemName = ((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='dealmintitle']")) ;
			        
			        HtmlElement modelNo = ((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='modal-no-div']")) ;
			          	
			       HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='marketprice']")) ;
					
					
			     //*ul[@id="filter-container"]/li[1]/a
			        
			        AbansItem item = new AbansItem();

				    item.setItemName(itemName.asText());
				    
				    item.setModelNo(modelNo.asText());
					

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
					
	

			//	FileWriter fw = new FileWriter(FILENAME, true);
				//	BufferedWriter bw = new BufferedWriter(fw);

					
				//	try {

					//	String content = jsonString + System.lineSeparator();
					//	bw.write(content);

				//	} catch (IOException e) {

					//	e.printStackTrace();

					//} finally {

					//	try {

						//	if (bw != null)
						//		bw.close();

						//	if (fw != null)
						//		fw.close();

						//} catch (IOException ex) {

							//ex.printStackTrace();

						//}

				//	}

				
					
					
					
					
					
				}
		    }
	
			
		} catch(Exception e){
			e.printStackTrace();
		}

		}
	}

}
