<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Electro</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Unicat project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="styles/responsive.css">
<%@ page import="java.io.IOException"%>
<%@ page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ page import="org.apache.solr.client.solrj.SolrServerException"%>
<%@ page import="org.apache.solr.client.solrj.impl.HttpSolrClient"%>
<%@ page import="org.apache.solr.client.solrj.impl.XMLResponseParser"%>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@ page import="org.apache.solr.common.SolrDocument"%>
<%@ page import="org.apache.solr.common.SolrDocumentList"%>
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
									<div class="logo_text">Elec<span>tro</span></div>
								</a>
							</div>
							<nav class="main_nav_contaner ml-auto">
								<ul class="main_nav">
									<li class="active"><a href="index.jsp">Home</a></li>
									<li><a href="about.html">About</a></li>
									<li><a href="contact.html">Contact</a></li>
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
			<form action="Search" class="header_search_form menu_mm" method="post">
				<input type="search" name="squery" class="search_input menu_mm" placeholder="Search" required="required">
				<button class="header_search_button d-flex flex-column align-items-center justify-content-center menu_mm">
					<i class="fa fa-search menu_mm" aria-hidden="true"></i>
				</button>
			</form>
		</div>
		<nav class="menu_nav">
			<ul class="menu_mm">
				<li class="menu_mm"><a href="index.jsp">Home</a></li>
				<li class="menu_mm"><a href="about.html">About</a></li>
				<li class="menu_mm"><a href="contact.html">Contact</a></li>
			</ul>
		</nav>
	</div>
	
	<!-- Home -->

	<div class="home">
		<div class="home_slider_container">
			
			<!-- Home Slider -->
			<div class="owl-carousel owl-theme home_slider">
				
				<!-- Home Slider Item -->
				<div class="owl-item">
					<div class="home_slider_background" style="background-image:url(images/home_slider_1.jpg)"></div>
					<div class="home_slider_content">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<div class="home_slider_title">Explore</div>
									<div class="home_slider_subtitle">Electronics at your touch</div>
									<div class="home_slider_form_container">
										<form action="Search" id="home_search_form_1" method="post" class="home_search_form d-flex flex-lg-row flex-column align-items-center justify-content-between">
											<div class="d-flex flex-row align-items-center justify-content-start">
												<input type="search" name="squery" class="home_search_input" placeholder="Keyword Search" required="required">
												<select name="store" class="dropdown_item_select home_search_input">
													<option value="*">Store</option>
													<option value="Ikman">Ikman</option>
													<option value="Kapruka">Kapruka</option>
													<option value="Buyabans">Buyabans</option>
													<option value="ClicknShop">ClicknShop</option>
													<option value="Scion">Scion</option>
												</select>
												<select name="condition" class="dropdown_item_select home_search_input">
													<option value="*">Condition</option>
													<option value="New">New</option>
													<option value="Used">Used</option>
												</select>
											</div>
											<button type="submit" class="home_search_button">search</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- End Home Slider Item -->
				
			</div>
		</div>
	</div>

<!-- Popular Items -->

	<div class="courses">
		<div class="section_background parallax-window" data-parallax="scroll" data-image-src="images/courses_background.jpg" data-speed="0.8"></div>
		<div class="container">
		
		<%
			SolrDocumentList docList = (SolrDocumentList) request.getAttribute("docList");
			for (int i = 0; i < docList.size(); i=i+3) {
				SolrDocument doc = docList.get(i);
				if(i<docList.size()){
				%>
				<div class="row courses_row">
					
					<!-- Item -->
					<div class="col-lg-4 course_col">
						<div class="course">
							<%String store = (String)doc.getFieldValue("store");
							if(store.equalsIgnoreCase("Ikman")){ %>
								<div class="course_image"><img src="images/ikman.jpg" alt=""></div>
							<%} else{ %>
								<div class="course_image"><img src=<%=doc.getFieldValue("img")%> alt=""></div>
							<%} %>
							<div class="course_body">
								<h3 class="course_title"><a href=<%=doc.getFieldValue("url")%>><%=doc.getFieldValue("title")%></a></h3>
								<div class="course_teacher"><%=doc.getFieldValue("location")%></div>
								<div class="course_text">
									<div style="width: 300px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><p><%=doc.getFieldValue("description")%></p></div>
								</div>
							</div>
							<div class="course_footer">
								<div class="course_footer_content d-flex flex-row align-items-center justify-content-start">
									<div class="course_info">
										<i class="fa fa-shopping-cart" aria-hidden="true"></i>
										<span><%=doc.getFieldValue("store")%></span>
									</div>
									<div class="course_info">
									<%
									String con = (String)doc.getFieldValue("condition");
									if(con.equalsIgnoreCase("new")) {%>
										<i class="fa fa-star" aria-hidden="true"></i>
									<%} else {%>
										<i class="fa fa-star-o" aria-hidden="true"></i>
									<%} %>
										<span><%=doc.getFieldValue("condition")%></span>
									</div>
									<div class="course_price ml-auto">Rs. <%=doc.getFieldValue("price")%></div>
								</div>
							</div>
						</div>
					</div>
				<%}
				if(i+1<docList.size()){
					doc = docList.get(i+1);%>
					<!-- Item -->
					<div class="col-lg-4 course_col">
						<div class="course">
							<%String store = (String)doc.getFieldValue("store");
							if(store.equalsIgnoreCase("Ikman")){ %>
								<div class="course_image"><img src="images/ikman.jpg" alt=""></div>
							<%} else{ %>
								<div class="course_image"><img src=<%=doc.getFieldValue("img")%> alt=""></div>
							<%} %>
							<div class="course_body">
								<h3 class="course_title"><a href=<%=doc.getFieldValue("url")%>><%=doc.getFieldValue("title")%></a></h3>
								<div class="course_teacher"><%=doc.getFieldValue("location")%></div>
								<div class="course_text">
									<div style="width: 300px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><p><%=doc.getFieldValue("description")%></p></div>
								</div>
							</div>
							<div class="course_footer">
								<div class="course_footer_content d-flex flex-row align-items-center justify-content-start">
									<div class="course_info">
										<i class="fa fa-shopping-cart" aria-hidden="true"></i>
										<span><%=doc.getFieldValue("store")%></span>
									</div>
									<div class="course_info">
									<%
									String con = (String)doc.getFieldValue("condition");
									if(con.equalsIgnoreCase("new")) {%>
										<i class="fa fa-star" aria-hidden="true"></i>
									<%} else {%>
										<i class="fa fa-star-o" aria-hidden="true"></i>
									<%} %>
										<span><%=doc.getFieldValue("condition")%></span>
									</div>
									<div class="course_price ml-auto">Rs. <%=doc.getFieldValue("price")%></div>
								</div>
							</div>
						</div>
					</div>
				<%}
				if(i+2<docList.size()){
					doc = docList.get(i+2);%>
					<!-- Item -->
					<div class="col-lg-4 course_col">
						<div class="course">
							<%String store = (String)doc.getFieldValue("store");
							if(store.equalsIgnoreCase("Ikman")){ %>
								<div class="course_image"><img src="images/ikman.jpg" alt=""></div>
							<%} else{ %>
								<div class="course_image"><img src=<%=doc.getFieldValue("img")%> alt=""></div>
							<%} %>
							<div class="course_body">
								<h3 class="course_title"><a href=<%=doc.getFieldValue("url")%>><%=doc.getFieldValue("title")%></a></h3>
								<div class="course_teacher"><%=doc.getFieldValue("location")%></div>
								<div class="course_text">
									<div style="width: 300px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><p><%=doc.getFieldValue("description")%></p></div>
								</div>
							</div>
							<div class="course_footer">
								<div class="course_footer_content d-flex flex-row align-items-center justify-content-start">
									<div class="course_info">
										<i class="fa fa-shopping-cart" aria-hidden="true"></i>
										<span><%=doc.getFieldValue("store")%></span>
									</div>
									<div class="course_info">
									<%
									String con = (String)doc.getFieldValue("condition");
									if(con.equalsIgnoreCase("new")) {%>
										<i class="fa fa-star" aria-hidden="true"></i>
									<%} else {%>
										<i class="fa fa-star-o" aria-hidden="true"></i>
									<%} %>
										<span><%=doc.getFieldValue("condition")%></span>
									</div>
									<div class="course_price ml-auto">Rs. <%=doc.getFieldValue("price")%></div>
								</div>
							</div>
						</div>
					</div>
					<%} %>
				</div>
			<%
			}
		%>
			
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
											<div class="footer_logo_text">Elec<span>tro</span></div>
										</a>
									</div>
									<div class="footer_about_text">
										<p>We are bunch of Data science undergrads who are keen on learning</p>
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
<script src="plugins/greensock/TweenMax.min.js"></script>
<script src="plugins/greensock/TimelineMax.min.js"></script>
<script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="plugins/greensock/animation.gsap.min.js"></script>
<script src="plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/custom.js"></script>
</body>
</html>