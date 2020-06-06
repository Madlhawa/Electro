<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="no-js h-100" lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Searchit | Search</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="description" content="Search for any online items and services across multiple sri lankan online stores">
	<meta property="og:title" content="SearchIt">
	<meta property="og:description" content="Search for any online items and services across multiple sri lankan online stores. ">
	<meta property="og:image" content="http://www.searchit.fun/images/LOGO.PNG">
	<meta property="og:url" content="http://www.searchit.lk/">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" type="image/png" sizes="16x16" href="images/favicon/favicon-16x16.png">
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" id="main-stylesheet" data-version="1.1.0" href="styles/shards-dashboards.1.1.0.min.css">
    <link rel="stylesheet" href="styles/extras.1.1.0.min.css">
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <style>
    	b, strong {
    		font-weight: 500;
		}
		a.text-fiord-blue:hover{
			color:#14bdee;
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
  <body class="h-100">
    <div class="container-fluid">
      <div class="row">
        <!-- Main Sidebar -->
        <aside class="main-sidebar col-12 col-md-3 col-lg-2 px-0">
          <div class="main-navbar">
            <nav class="navbar align-items-stretch navbar-light bg-white flex-md-nowrap border-bottom p-0">
              <a class="navbar-brand w-100 mr-0" href="#" style="line-height: 25px;">
                <div class="d-table m-auto">
                  <img id="main-logo" class="d-inline-block align-top mr-1" style="max-width: 25px;" src="images/content-management/IconsFilter.png" alt="Shards Dashboard">
                  <span class="d-none d-md-inline ml-1">Filter</span>
                </div>
              </a>
              <a class="toggle-sidebar d-sm-inline d-md-none d-lg-none">
                <i class="material-icons">&#xE5C4;</i>
              </a>
            </nav>
          </div>
          <%
			FacetField storeField = (FacetField) request.getAttribute("storeField");
			FacetField conditionField = (FacetField) request.getAttribute("conditionField");
			FacetField locationField = (FacetField) request.getAttribute("locationField");
			double minPrice = (double) request.getAttribute("minPrice");
			double maxPrice = (double) request.getAttribute("maxPrice");
			Map<String, Map<String, List<String>>> highlights = (Map<String, Map<String, List<String>>>) request.getAttribute("highlights");	
			%>
		<form action="Facet" method="post">
          <div class="nav-wrapper">
            <br>
              <div class="input-group mb-3" style="padding-left: 10px;padding-right: 10px">
                  <input type="text" name="squery" class="form-control" id="inputAddress" placeholder="<%=request.getAttribute("userQuery")%>" value="<%=request.getAttribute("userQuery")%>">
              </div>
              <div style="padding-left: 12px;padding-right: 5px">
                  <div class="custom-control custom-checkbox mb-1" >
                      <input name="pricerange" value="true" type="checkbox" class="custom-control-input" id="formsCheckboxDefault">
                      <label class="custom-control-label" for="formsCheckboxDefault">Apply price filter</label>
                  </div>
              </div>
              <div class="input-group mb-1" style="padding-left: 10px;padding-right: 10px">
                  <div class="input-group-prepend">
                      <span class="input-group-text">Min</span>
                  </div>
                 <input type="text" name="minPrice" class="form-control" value='<%=minPrice%>' aria-label="Username" aria-describedby="basic-addon1"> 
              </div>
              <div class="input-group mb-3" style="padding-left: 10px;padding-right: 10px">
                  <input type="text" name="maxPrice" class="form-control" value='<%=maxPrice%>' aria-label="" aria-describedby="basic-addon2" value="contact">
                  <div class="input-group-append">
                      <span class="input-group-text">Max</span>
                  </div>
              </div>
              
                <div class="container">
                  <div class="row">
                      <div class="col-sm-offset-1 col-sm-10">
                          <strong class="text-muted d-block mb-1" style="padding-left: 8%;">Store</strong>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-sm-offset-3 col-sm-12">
                          <fieldset style="padding-left: 12%;padding-right: 5px">
                              <div class="custom-control custom-checkbox mb-1">
                                  <input name="store" value="*" type="checkbox" class="custom-control-input" id="formsCheckboxChecked" checked>
                                  <label class="custom-control-label" for="formsCheckboxChecked">All stores</label>
                              </div>
                              <%for(int j=0;j<storeField.getValueCount();j++){ %>
	                              <div class="custom-control custom-checkbox mb-1">
	                                  <input name="store" value='<%=storeField.getValues().get(j) %>'type="checkbox" class="custom-control-input" id="<%=100+j%>">
	                                  <label class="custom-control-label" for="<%=100+j%>"><%=storeField.getValues().get(j) %></label>
	                              </div>
                              <%} %>
                              <!-- 
	                              <div class="custom-control custom-checkbox mb-1">
	                                  <input type="checkbox" class="custom-control-input" id="formsCheckboxDisabled" disabled>
	                                  <label class="custom-control-label" for="formsCheckboxDisabled">Disabled</label>
	                              </div>
	                              <div class="custom-control custom-checkbox mb-1">
	                                  <input type="checkbox" class="custom-control-input" id="formsCheckboxDisabledChecked" disabled checked>
	                                  <label class="custom-control-label" for="formsCheckboxDisabledChecked">Disabled Checked</label>
	                              </div>
                               -->
                          </fieldset>
                      </div>
                  </div>
                </div>
                <br>
                <div style="padding-left: 15px;padding-right: 5px">
                    <strong class="text-muted d-block mb-1">Location</strong>
                </div>
                <div class="input-group mb-3" style="padding-left: 10px;padding-right: 10px">
                    <div class="form-group" style="width: 100%;">
                        <select id="inputState" name="location" class="form-control" >
                            <option value="*" selected>Choose...</option>
                            <%for(int k=0;k<locationField.getValueCount();k++){ %>
								<%if(!locationField.getValues().get(k).toString().split(" ")[0].matches(".*\\d+.*")){ %>
									<option value='<%=locationField.getValues().get(k)%>' ><%=locationField.getValues().get(k)%></option>
								<%} %>
							<%}%>
                        </select>
                    </div>
                </div>
                <div class="container">
                  
                  <div class="row">
                      <div class="col-sm-offset-1 col-sm-10">
                          <strong class="text-muted d-block mb-2" style="padding-left: 8%;">Category</strong>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-sm-offset-3 col-sm-12">
                          <fieldset style="padding-left: 12%;padding-right: 5px">
                          	  <div class="custom-control custom-radio mb-1">
                                  <input type="radio" id="formsRadioChecked" name="condition" value="*" class="custom-control-input" checked>
                                  <label class="custom-control-label" for="formsRadioChecked">All</label>
                              </div>
                              <%for(int l=0;l<conditionField.getValueCount();l++){ %>
                              	<%if(!conditionField.getValues().get(l).toString().split(" ")[0].matches(".*\\d+.*")){ %>
	                              <div class="custom-control custom-radio mb-1">
	                                  <input type="radio" id="<%=l %>" name="condition" value='<%=conditionField.getValues().get(l) %>' class="custom-control-input">
	                                  <label class="custom-control-label" for="<%=l %>"><%=conditionField.getValues().get(l) %></label>
	                              </div>
	                             <%} %>
							  <%} %>
                              <!-- 
	                              <div class="custom-control custom-radio mb-1">
	                                  <input type="radio" id="formsRadioDisabled" name="formsRadioDisabled" class="custom-control-input" disabled>
	                                  <label class="custom-control-label" for="formsRadioDisabled">Disabled</label>
	                              </div>
	                              <div class="custom-control custom-radio mb-1">
	                                  <input type="radio" id="formsRadioDisabledChecked" name="formsRadioDisabledChecked" class="custom-control-input" disabled checked>
	                                  <label class="custom-control-label" for="formsRadioDisabledChecked">Disabled Checked</label>
	                              </div>
                               -->
                          </fieldset>
                      </div>
                  </div>
              </div>
              <br>
            <div style="text-align:center;"><button type="submit" class="mb-2 btn btn-outline-primary mr-2">Filter</button></div>
          </div>
          </form>
        </aside>
        <!-- End Main Sidebar -->
        <main class="main-content col-lg-10 col-md-9 col-sm-12 p-0 offset-lg-2 offset-md-3">
          <div class="main-navbar sticky-top bg-white">
            <!-- Main Navbar -->
            <nav class="navbar align-items-stretch navbar-light flex-md-nowrap p-0">
              <form action="Find" class="main-navbar__search w-100 d-none d-md-flex d-lg-flex" method="post">
                <div class="input-group input-group-seamless ml-3">
                  <div class="input-group-prepend">
                    <div class="input-group-text">
                      <i class="fas fa-search" style="font-size:15px"></i>
                    </div>
                  </div>
                  <input class="navbar-search form-control" type="text" placeholder="Search for something..." aria-label="Search" name="squery" style="font-size:19px"> </div>
              </form>
              <ul class="navbar-nav border-left flex-row ">
                <!-- 
                <li class="nav-item border-right dropdown notifications">
                  <a class="nav-link nav-link-icon text-center" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <div class="nav-link-icon__wrapper">
                      <i class="material-icons">&#xE7F4;</i>
                      <span class="badge badge-pill badge-danger">2</span>
                    </div>
                  </a>
                  <div class="dropdown-menu dropdown-menu-small" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="#">
                      <div class="notification__icon-wrapper">
                        <div class="notification__icon">
                          <i class="material-icons">&#xE6E1;</i>
                        </div>
                      </div>
                      <div class="notification__content">
                        <span class="notification__category">Analytics</span>
                        <p>Your website’s active users count increased by
                          <span class="text-success text-semibold">28%</span> in the last week. Great job!</p>
                      </div>
                    </a>
                    <a class="dropdown-item" href="#">
                      <div class="notification__icon-wrapper">
                        <div class="notification__icon">
                          <i class="material-icons">&#xE8D1;</i>
                        </div>
                      </div>
                      <div class="notification__content">
                        <span class="notification__category">Sales</span>
                        <p>Last week your store’s sales count decreased by
                          <span class="text-danger text-semibold">5.52%</span>. It could have been worse!</p>
                      </div>
                    </a>
                    <a class="dropdown-item notification__all text-center" href="#"> View all Notifications </a>
                  </div>
                </li>
                 -->
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle text-nowrap px-3" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <img class="user-avatar rounded-circle mr-2" src="images/favicon.png" alt="User Avatar">
                    <span class="d-none d-md-inline-block" style="color:#384158">Search<span style="color:#14bdee">it</span></span>
                  </a>
                  <div class="dropdown-menu dropdown-menu-small">
                    <!-- <a class="dropdown-item" href="user-profile-lite.html">
                      <i class="material-icons">&#xE7FD;</i> Profile</a> -->
                    <a class="dropdown-item" href="index.jsp">
                      <i class="material-icons">vertical_split</i> Home</a>
                    <a class="dropdown-item" href="about.html">
                      <i class="material-icons">note_add</i> About</a>
                    <!-- <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-danger" href="#">
                      <i class="material-icons text-danger">&#xE879;</i> Logout </a> -->
                  </div>
                </li>
              </ul>
              <nav class="nav">
                <a href="#" class="nav-link nav-link-icon toggle-sidebar d-md-inline d-lg-none text-center border-left" data-toggle="collapse" data-target=".header-navbar" aria-expanded="false" aria-controls="header-navbar">
                  <i class="material-icons">&#xE5D2;</i>
                </a>
              </nav>
            </nav>
          </div>
          <!-- / .main-navbar -->
          <div class="main-content-container container-fluid px-4">
            <!-- Page Header -->
            <div class="page-header row no-gutters py-4">
              <div class="col-12 col-sm-4 text-center text-sm-left mb-0">
                <span class="text-uppercase page-subtitle">Results | <%=request.getAttribute("qtime") %> seconds</span>
                <!--<p class="page-title">Blog Posts</p>-->
              </div>
            </div>
            <!-- End Page Header -->
            <%if(!(boolean)request.getAttribute("results")){ %>
								<div class="section_title_container text-center">
									<div class="section_subtitle"><h4 style="color:red;">No results found</h4></div>
								</div>
						<%} %>
			<%	SolrDocumentList docList = (SolrDocumentList) request.getAttribute("docList");
				for (int i = 0; i < docList.size();i=i+4) { %>
		             <div class="row">
		             <%	SolrDocument doc = docList.get(i);
		             	String img = (String) doc.getFieldValue("img");
						String con = (String)doc.getFieldValue("condition");
						if (doc.getFieldValue("img").toString().equalsIgnoreCase("na")){
							img = "images/default-image.svg";
						}
		             	if(i<docList.size()){ %>
			              <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
			                <div class="card card-small card-post card-post--1">
			                  <div class="card-post__image" style="background-image: url('<%=img%>');">
			                    <a href="<%=doc.getFieldValue("url")%>" class="card-post__category badge badge-pill badge-info"><%=doc.getFieldValue("store") %></a>
			                    <div class="card-post__author d-flex">
			                    	<%if(con.equalsIgnoreCase("new")) {%>
	                      				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url(images/star-new.png);">New</a>
	                    			<%}else{ %>
	                    				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url('images/star-used.png');">Used</a>
	                    			<%} %>
			                    </div>
			                  </div>
			                  <div class="card-body">
			                    <h5 class="card-title">
			                      <a class="text-fiord-blue" href="<%=doc.getFieldValue("url")%>"><%=highlights.get(doc.getFieldValue("id")).get("title").get(0)%></a>
			                    </h5>
			                    <%if(doc.getFieldValue("description")!=null){ %>
									<p class="card-text d-inline-block mb-3" style="max-height:45px; overflow: hidden;"><%=doc.getFieldValue("description")%></p>
								<%} %>
			                    <span class="text-muted"><%=doc.getFieldValue("location")%></span>
			                    <%if(!doc.getFieldValue("price").toString().equalsIgnoreCase("0.0"))  {%>
	                    			<span class="price" style="color:#14bdee;float: right;font-size: 20px;">Rs. <%=doc.getFieldValue("price")%></span>
	                   		 	<%} %>
			                  </div>
			                </div>
			              </div>
		              <%}
						if(i+1<docList.size()){
		              		doc = docList.get(i+1);
							img = (String) doc.getFieldValue("img");
							con = (String)doc.getFieldValue("condition");
							if (doc.getFieldValue("img").toString().equalsIgnoreCase("na")){
								img = "images/default-image.svg";
							} %>
				              <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
				                <div class="card card-small card-post card-post--1">
				                  <div class="card-post__image" style="background-image: url('<%=img%>');">
				                    <a href="<%=doc.getFieldValue("url")%>" class="card-post__category badge badge-pill badge-info"><%=doc.getFieldValue("store") %></a>
				                    <div class="card-post__author d-flex">
				                    	<%if(con.equalsIgnoreCase("new")) {%>
		                      				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url(images/star-new.png);">New</a>
		                    			<%}else{ %>
		                    				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url('images/star-used.png');">Used</a>
		                    			<%} %>
				                    </div>
				                  </div>
				                  <div class="card-body">
				                    <h5 class="card-title">
				                      <a class="text-fiord-blue" href="<%=doc.getFieldValue("url")%>"><%=highlights.get(doc.getFieldValue("id")).get("title").get(0)%></a>
				                    </h5>
				                    <%if(doc.getFieldValue("description")!=null){ %>
										<p class="card-text d-inline-block mb-3" style="max-height:45px; overflow: hidden;"><%=doc.getFieldValue("description")%></p>
									<%} %>
				                    <span class="text-muted"><%=doc.getFieldValue("location")%></span>
				                    <%if(!doc.getFieldValue("price").toString().equalsIgnoreCase("0.0"))  {%>
		                    			<span class="price" style="color:#14bdee;float: right;font-size: 20px;">Rs. <%=doc.getFieldValue("price")%></span>
		                   		 	<%} %>
				                  </div>
				                </div>
				              </div>
		              <%}
						if(i+2<docList.size()){
			              	doc = docList.get(i+2);
							img = (String) doc.getFieldValue("img");
							con = (String)doc.getFieldValue("condition");
							if (doc.getFieldValue("img").toString().equalsIgnoreCase("na")){
								img = "images/default-image.svg";
							} %>
			              <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
			                <div class="card card-small card-post card-post--1">
			                  <div class="card-post__image" style="background-image: url('<%=img%>');">
			                    <a href="<%=doc.getFieldValue("url")%>" class="card-post__category badge badge-pill badge-info"><%=doc.getFieldValue("store") %></a>
			                    <div class="card-post__author d-flex">
			                    	<%if(con.equalsIgnoreCase("new")) {%>
	                      				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url(images/star-new.png);">New</a>
	                    			<%}else{ %>
	                    				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url('images/star-used.png');">Used</a>
	                    			<%} %>
			                    </div>
			                  </div>
			                  <div class="card-body">
			                    <h5 class="card-title">
			                      <a class="text-fiord-blue" href="<%=doc.getFieldValue("url")%>"><%=highlights.get(doc.getFieldValue("id")).get("title").get(0)%></a>
			                    </h5>
			                    <%if(doc.getFieldValue("description")!=null){ %>
									<p class="card-text d-inline-block mb-3" style="max-height:45px; overflow: hidden;"><%=doc.getFieldValue("description")%></p>
								<%} %>
			                    <span class="text-muted"><%=doc.getFieldValue("location")%></span>
			                    <%if(!doc.getFieldValue("price").toString().equalsIgnoreCase("0.0"))  {%>
	                    			<span class="price" style="color:#14bdee;float: right;font-size: 20px;">Rs. <%=doc.getFieldValue("price")%></span>
	                   		 	<%} %>
			                  </div>
			                </div>
			              </div>
		              <%}
						if(i+3<docList.size()){
							doc = docList.get(i+3);
							img = (String) doc.getFieldValue("img");
							con = (String)doc.getFieldValue("condition");
							if (doc.getFieldValue("img").toString().equalsIgnoreCase("na")){
								img = "images/default-image.svg";
							} %>
			              <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
			                <div class="card card-small card-post card-post--1">
			                  <div class="card-post__image" style="background-image: url('<%=img%>');">
			                    <a href="<%=doc.getFieldValue("url")%>" class="card-post__category badge badge-pill badge-info"><%=doc.getFieldValue("store") %></a>
			                    <div class="card-post__author d-flex">
			                    	<%if(con.equalsIgnoreCase("new")) {%>
	                      				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url(images/star-new.png);">New</a>
	                    			<%}else{ %>
	                    				<a href="<%=doc.getFieldValue("url")%>" class="card-post__author-avatar card-post__author-avatar--small" style="background-image: url('images/star-used.png');">Used</a>
	                    			<%} %>
			                    </div>
			                  </div>
			                  <div class="card-body">
			                    <h5 class="card-title">
			                      <a class="text-fiord-blue" href="<%=doc.getFieldValue("url")%>"><%=highlights.get(doc.getFieldValue("id")).get("title").get(0)%></a>
			                    </h5>
			                    <%if(doc.getFieldValue("description")!=null){ %>
									<p class="card-text d-inline-block mb-3" style="max-height:45px; overflow: hidden;"><%=doc.getFieldValue("description")%></p>
								<%} %>
			                    <span class="text-muted"><%=doc.getFieldValue("location")%></span>
			                    <%if(!doc.getFieldValue("price").toString().equalsIgnoreCase("0.0"))  {%>
	                    			<span class="price" style="color:#14bdee;float: right;font-size: 20px;">Rs. <%=doc.getFieldValue("price")%></span>
	                   		 	<%} %>
			                  </div>
			                </div>
			              </div>
			              <%} %>
		      		</div>
		      		<%} %>
          <footer class="main-footer d-flex p-2 px-3 bg-white border-top">
            <ul class="nav">
              <li class="nav-item">
                <a class="nav-link" href="index.jsp">Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="about.html">About</a>
              </li>
            </ul>
            <span class="copyright ml-auto my-auto mr-2">Copyright © 2018
              <a href="https://designrevision.com" rel="nofollow">DesignRevision</a>
            </span>
          </footer>
        </main>
      </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
    <script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
    <script src="scripts/extras.1.1.0.min.js"></script>
    <script src="scripts/shards-dashboards.1.1.0.min.js"></script>
  </body>
</html>