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

public class Mydeallk { 
	
	
	//private static final String FILENAME = "C:\\Users\\jajja\\Desktop\\data\\audio-video-accessories\\Mydeal.json";

	public static void main(String[] args) {
		
	
	
		
		
		String baseUrl = "https://mydeal.lk/audio-video-accessories" ;
		WebClient client = new WebClient();
		client.getOptions().setCssEnabled(false);
		client.getOptions().setJavaScriptEnabled(false);
		
		
		try {
			
			
			String searchUrl = baseUrl;
			HtmlPage page = client.getPage(searchUrl);		
			
			List<HtmlElement> items = (List<HtmlElement>) page.getByXPath("//div[@class='col-sm-6 col-md-3 panel-deal deal-not-purchasable']") ;
			
			//System.out.println(page);
			
			//System.out.println(items);
			
		
			
		    if(items.isEmpty())
		   {
				System.out.println("No items found !");
			}
		    else
		    {
		    	
				for(HtmlElement htmlItem : items){
					
			          HtmlAnchor itemAnchor = ((HtmlAnchor) htmlItem.getFirstByXPath(".//div[@class='deal-wrapper']/a"));
			          
			        HtmlElement itemName = ((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='deal-wrapper']/h4/a")) ;
			        
			        HtmlElement price = ((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='deal-wrapper']/h5/small")) ;
					
					//HtmlElement UnionBankCreditCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
					
					//HtmlElement priceUnionBankCreditCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
			
					//HtmlElement NDBBankCreditCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
					
					//HtmlElement priceNDBBankCreditCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
	
					//HtmlElement UnionBankDebitCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
					
					//HtmlElement priceUnionBankDebitCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
							
					//HtmlElement NDBBankDebittCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
					
					//HtmlElement priceNDBBankDebitCards = ((HtmlElement) htmlItem.getFirstByXPath(".//p[@class='item-info']/strong")) ;
					
					//HtmlElement Warranty = ((HtmlElement) htmlItem.getFirstByXPath(".//div[@class='item-content']/a"));
					
					MydeallkItem item = new MydeallkItem();

					item.setTitle(itemAnchor.asText());
					
					item.setItemName(itemName.asText());
					
					item.setPrice(price.asText());
					
					//item.setUnionBankCreditCards(UnionBankCreditCards.asText());
				
					//item.setPriceUnionBankCreditCards(priceUnionBankCreditCards.asText());
					
					//item.setNDBBankCreditCards(NDBBankCreditCards.asText());
					
					//item.setPriceNDBBankCreditCards(priceNDBBankCreditCards.asText());
					
					//item.setUnionBankDebitCards(UnionBankDebitCards.asText());
					
					//item.setPriceUnionBankDebitCards(priceUnionBankDebitCards.asText());
					
					//item.setNDBBankDebittCards(NDBBankDebittCards.asText());
					
					//item.setPriceNDBBankDebitCards(priceNDBBankDebitCards.asText());
					
					
				
					/*if(Warranty==null)
					{
						item.setWarranty("No warranty");
					
					}else {
						
						item.setWarranty(Warranty.asText());
					}*/
					
					
					
					item.setUrl(baseUrl + itemAnchor.getHrefAttribute());
					
				
					
					ObjectMapper mapper = new ObjectMapper();
					String jsonString = mapper.writeValueAsString(item) ;
					
			        System.out.println(jsonString);
					
	

					//FileWriter fw = new FileWriter(FILENAME, true);
					//BufferedWriter bw = new BufferedWriter(fw);

					
				/*	try {

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

				*/
					
					
					
					
					
				}
		    }
	
			
		} catch(Exception e){
			e.printStackTrace();
		}

	
	}

}
