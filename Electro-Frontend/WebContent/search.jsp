<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Searchit | Search</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Search for any online items and services across multiple sri lankan online stores">
<meta property="og:title" content="SearchIt">
<meta property="og:description" content="Search for any online items and services across multiple sri lankan online stores. ">
<meta property="og:image" content="http://www.searchit.fun/images/LOGO.PNG">
<meta property="og:url" content="http://www.searchit.fun/">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/png" sizes="16x16" href="images/favicon/favicon-16x16.png">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="plugins/video-js/video-js.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="styles/blog.css">
<link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/prettyPhoto.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<link href="css/responsive.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="styles/responsive.css">
<style>
.filterbox{
	border: 0px solid #696763;
	background: #F0F0E9;
	color: #696763;
	padding: 5px;
}
b, strong {
    font-weight: bold;
}
</style>
<%@ page import="java.io.IOException"%>
<%@ page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ page import="org.apache.solr.client.solrj.SolrServerException"%>
<%@ page import="org.apache.solr.client.solrj.impl.HttpSolrClient"%>
<%@ page import="org.apache.solr.client.solrj.impl.XMLResponseParser"%>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@ page import="org.apache.solr.common.SolrDocument"%>
<%@ page import="org.apache.solr.common.SolrDocumentList"%>
<%@ page import="org.apache.solr.client.solrj.response.FacetField"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
</head>
<body>

<div class="super_container">

	<!-- Header -->

	<header class="header">
			

		<!-- Header Content -->
		<div class="header_container">
			<div class="container">
				<div class="row">
					<div class="col">
						<div class="header_content d-flex flex-row align-items-center justify-content-start">
							<div class="logo_container">
								<a href="index.jsp">
									<div class="logo_text">Search<span>it</span></div>
								</a>
							</div>
							<nav class="main_nav_contaner ml-auto">
								<ul class="main_nav">
									<li><a href="index.jsp">Home</a></li>
									<li><a href="about.html">About</a></li>
								</ul>
								<div class="search_button"><i class="fa fa-search" aria-hidden="true"></i></div>

								<!-- Hamburger -->
								
								<div class="hamburger menu_mm">
									<i class="fa fa-bars menu_mm" aria-hidden="true"></i>
								</div>
							</nav>

						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Header Search Panel -->
		<div class="header_search_container">
			<div class="container">
				<div class="row">
					<div class="col">
						<div class="header_search_content d-flex flex-row align-items-center justify-content-end">
							<form action="Search" class="header_search_form" method="post">
								<input type="search" name="squery" class="search_input" placeholder="Search" required="required">
								<button type="submit" class="header_search_button d-flex flex-column align-items-center justify-content-center">
									<i class="fa fa-search" aria-hidden="true"></i>
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>			
		</div>	
	</header>

	<!-- Menu -->

	<div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
		<div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
		<div class="search">
			<form action="#" class="header_search_form menu_mm">
				<input type="search" class="search_input menu_mm" placeholder="Search" required="required">
				<button class="header_search_button d-flex flex-column align-items-center justify-content-center menu_mm">
					<i class="fa fa-search menu_mm" aria-hidden="true"></i>
				</button>
			</form>
		</div>
		<nav class="menu_nav">
			<ul class="menu_mm">
				<li class="menu_mm"><a href="index.html">Home</a></li>
				<li class="menu_mm"><a href="#">About</a></li>
				<li class="menu_mm"><a href="contact.html">Contact</a></li>
			</ul>
		</nav>
	</div>

	<!-- Blog -->

	<div class="blog">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="blog_post_container">

						<!-- Blog Post -->
						<div class="blog_post trans_200">
							<div class="blog_post_body">
								<%
								FacetField storeField = (FacetField) request.getAttribute("storeField");
								FacetField conditionField = (FacetField) request.getAttribute("conditionField");
								FacetField locationField = (FacetField) request.getAttribute("locationField");
								double minPrice = (double) request.getAttribute("minPrice");
								double maxPrice = (double) request.getAttribute("maxPrice");
								Map<String, Map<String, List<String>>> highlights = (Map<String, Map<String, List<String>>>) request.getAttribute("highlights");
								
								
								%>
								<form action="Facet" id="home_search_form_1" method="post">
									<div class="cd-filter-block">
										<div class="col text-center">
											<h2>Filter</h2>
										</div>
										<div class="cd-filter-content">
											<input name="squery" type="search" class="filterbox" value='<%=request.getAttribute("userQuery")%>' style="width:99%" required>
										</div> <!-- cd-filter-content --><br>
										<div class="cd-filter-block">
											<ul class="cd-filter-content cd-filters list">
												<li>
													<input name="pricerange" value="true" class="filter" data-filter=".check1" type="checkbox" id="checkbox1" >
													<label class="checkbox-label" for="checkbox1">Apply price range</label>
												</li>
												<div class="cd-filter-content">
													<input name="minPrice" type="search" class="filterbox" value='<%=minPrice%>' style="width:49%">
													<input name="maxPrice" type="search" class="filterbox" value='<%=maxPrice%>' style="width:49%">
												</div> <!-- cd-filter-content -->
											</ul> <!-- cd-filter-content -->
										</div> <!-- cd-filter-block -->
									</div> <!-- cd-filter-block -->
									<br>
									<div class="cd-filter-block">
										<h4>Store</h4>
										<ul class="cd-filter-content cd-filters list">
											<li>
												<input name="store" value="*" class="filter" data-filter=".check1" type="checkbox" id="checkbox1" checked>
												<label class="checkbox-label" for="checkbox1">All stores</label>
											</li>
										<%for(int j=0;j<storeField.getValueCount();j++){ %>
											<li>
												<input name="store" value='<%=storeField.getValues().get(j) %>' class="filter" data-filter=".check1" type="checkbox" id="checkbox1">
												<label class="checkbox-label" for="checkbox1"><%=storeField.getValues().get(j) %></label>
											</li>
										<%} %>
										</ul> <!-- cd-filter-content -->
									</div> <!-- cd-filter-block -->
									<br>
									<div class="cd-filter-block">
										<h4>Location</h4>
										<div class="cd-filter-content">
											<div class="cd-select cd-filters">
												<select class="filter" name="location" id="selectThis">
													<option value="*">Choose an option</option>
													<%for(int k=0;k<locationField.getValueCount();k++){ %>
														<%if(!locationField.getValues().get(k).toString().split(" ")[0].matches(".*\\d+.*")){ %>
															<option value='<%=locationField.getValues().get(k)%>' ><%=locationField.getValues().get(k)%></option>
														<%} %>
													<%}%>
												</select>
											</div> <!-- cd-select -->
										</div> <!-- cd-filter-content -->
									</div> <!-- cd-filter-block -->
									<br>
									<div class="cd-filter-block">
										<h4>Category</h4>
										<ul class="cd-filter-content cd-filters list">
											<li>
												<input class="filter" data-filter="" type="radio" name="condition" id="radio1" value="*" checked>
												<label class="radio-label" for="radio1">All</label>
											</li>
											<%for(int l=0;l<conditionField.getValueCount();l++){ %>
												<%if(!conditionField.getValues().get(l).toString().split(" ")[0].matches(".*\\d+.*")){ %>
													<li>
														<input class="filter" data-filter=".radio2" type="radio" name="condition" value='<%=conditionField.getValues().get(l) %>' id="radio2">
														<label class="radio-label" for="radio2"><%=conditionField.getValues().get(l) %></label>
													</li>
												<%} %>
											<%} %>
										</ul> <!-- cd-filter-content -->
									</div> <!-- cd-filter-block -->
									<div class="col text-center">
										<button type="submit" class="counter_form_button">Filter</button>
									</div>
								</form>
							</div>
						</div>
						<%if(!(boolean)request.getAttribute("results")){ %>
								<div class="section_title_container text-center">
									<div class="section_subtitle"><h4 style="color:red;">No results found</h4></div>
								</div>
						<%} %>
						<%
						SolrDocumentList docList = (SolrDocumentList) request.getAttribute("docList");
						for (int i = 0; i < docList.size(); i++) {
							SolrDocument doc = docList.get(i);%>
							<!-- Blog Post -->
							<div class="blog_post trans_200">
								<div class="blog_post_image"><img src=<%=doc.getFieldValue("img")%> alt=""></div>
								<div class="blog_post_body">
									<div class="blog_post_title"><a href="<%=doc.getFieldValue("url")%>"><%=highlights.get(doc.getFieldValue("id")).get("title").get(0)%></a></div>
									<div class="blog_post_meta">
										<ul>
											<i class="fa fa-shopping-cart" aria-hidden="true" style="color: #ffc80a;"></i>
											<li><a href="#"><%=doc.getFieldValue("store") %></a></li>
											<%
											String con = (String)doc.getFieldValue("condition");
											if(con.equalsIgnoreCase("new")) {%>
												<i class="fa fa-star" aria-hidden="true" style="color: #ffc80a;"></i>
											<%} else {%>
												<i class="fa fa-star-o" aria-hidden="true" style="color: #ffc80a;"></i>
											<%} %>
											<li><a href="#"><%=doc.getFieldValue("condition")%></a></li>
										</ul>
									</div>
									<div class="blog_post_text">
										<div style="width:100%; max-height:145px; overflow: hidden;">
											<%if(doc.getFieldValue("description")!=null){ %>
												<p><%=doc.getFieldValue("description")%></p>
											<%} %>
										</div>
									</div>
									<div class="blog_post_meta" style="text-align:left; margin-top: 5px">
										<ul>
											<li><b><%=doc.getFieldValue("location")%></b></li>
										</ul>
									</div>
									<div class="blog_post_title" style="text-align:right; color:#14bdee;"><a>Rs. <%=doc.getFieldValue("price")%></a></div>
								</div>
								
							</div>
						<%} %>				
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->

	<footer class="footer">
		<div class="footer_background" style="background-image:url(images/footer_background.png)"></div>
		<div class="container">
			<div class="row footer_row">
				<div class="col">
					<div class="footer_content">
						<div class="row">

							<div class="col-lg-3 footer_col">
					
								<!-- Footer About -->
								<div class="footer_section footer_about">
									<div class="footer_logo_container">
										<a href="index.jsp">
											<div class="footer_logo_text">Search<span>it</span></div>
										</a>
									</div>
									<div class="footer_about_text">
										<p>We are bunch of Data science undergrads who are keen on learning.</p>
									</div>
									<div class="footer_social">
										<ul>
											<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
											<li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
											<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
											<li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
										</ul>
									</div>
								</div>
								
							</div>

							<div class="col-lg-3 footer_col">
					
								<!-- Footer Contact -->
								<div class="footer_section footer_contact">
									<div class="footer_title">Contact Us</div>
									<div class="footer_contact_info">
										<ul>
											<li>Email: madhawa242@gmail.com</li>
											<li>SLIIT, Malabe</li>
										</ul>
									</div>
								</div>
								
							</div>

							<div class="col-lg-3 footer_col">
					
								<!-- Footer links -->
								<div class="footer_section footer_links">
									<div class="footer_title">Contact Us</div>
									<div class="footer_links_container">
										<ul>
											<li><a href="index.jsp">Home</a></li>
											<li><a href="about.html">About</a></li>
											<li><a href="contact.html">Contact</a></li>
										</ul>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row copyright_row">
				<div class="col">
					<div class="copyright d-flex flex-lg-row flex-column align-items-center justify-content-start">
						<div class="cr_text"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | Web design is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></div>
						<div class="ml-lg-auto cr_links">
							<ul class="cr_list">
								<li><a href="#">Copyright notification</a></li>
								<li><a href="#">Terms of Use</a></li>
								<li><a href="#">Privacy Policy</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
</div>



<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/masonry/masonry.js"></script>
<script src="plugins/video-js/video.min.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/blog.js"></script>
</body>
</html>