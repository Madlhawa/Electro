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

public class Kapruka_Kitchen { 
	
	
	private static final String FILENAME = "C:\\Users\\jajja\\Desktop\\data\\kapruka\\Kitchen.json";

	public static void main(String[] args) {
		
	
		for(int i=1;i<=7;i++)
		{
		
		
		String baseUrl = "https://www.kapruka.com/shops/specialGifts/electronicsSelectPage.jsp?subcat=Kitchen%20Appliances" ;
		WebClient client = new WebClient();
		client.getOptions().setCssEnabled(false);
		client.getOptions().setJavaScriptEnabled(false);
		
		
		try {
			
			
			String searchUrl = baseUrl+"&p="+i;
			HtmlPage page = client.getPage(searchUrl);		
			
			List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//li[@class='the-cat hovered']") ;
			
			//System.out.println(page);
			
		//	System.out.println(items);
			
	
			
		    if(items.isEmpty())
		   {
				System.out.println("No items found !");
			}
		    else
		    {
		    	
				for(HtmlElement htmlItem : items){
					
			        HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//div[@class='prod-wrap']/a"));
			        
			        HtmlElement itemName = ((HtmlElement) htmlItem.getFirstByXPath(".//span[@class='text-gray']")) ;
			          	
			       HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//span[@class='text-green']")) ;
					
					
			        
			        
			        KaprukaItem item = new KaprukaItem();

				    item.setItemName(itemName.asText());
					

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

							if (fw != null)
								fw.close();

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
