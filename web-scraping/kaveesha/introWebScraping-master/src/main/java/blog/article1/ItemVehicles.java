package blog.article1;

import java.math.BigDecimal;
import java.sql.Time;

public class ItemVehicles { 
	
	private String title ; 
	private String price ;
	private String location;
	private String category;
	
	
	private String url ;
	
	private String distance;
 
	
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
	
	public String getDistance() {
		return distance;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	


	

	
	
}
