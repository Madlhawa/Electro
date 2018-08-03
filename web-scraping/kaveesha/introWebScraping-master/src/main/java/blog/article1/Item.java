package blog.article1;

import java.math.BigDecimal;
import java.sql.Time;

public class Item {
	
	private String title ; 
	private String price ;
	private String location;
	private String category;
	private String url ;
	
	//private String timeuntillnow;
 
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	public String getCategory() {
		return category;
	}
	public void setcategory(String category) {
		this.category = category;
	}
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
/*	
	public String getTime() {
		return timeuntillnow;
	}
	public void setTime(String time) {
		this.timeuntillnow = time;
	}
*/	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	


	

	
	
}
