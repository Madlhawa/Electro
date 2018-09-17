# -*- coding: utf-8 -*-
import re
import os
import scrapy
import unicodedata
from money_parser import price_str

class LankatSpider(scrapy.Spider):
	name = 'lankat'
	#allowed_domains = ['https://www.lankatronics.com/']
	start_urls = ['https://www.lankatronics.com/']


	def parse(self, response):
		pages = ["development-tools","top-brands","modules-sensors","robot-accessories","semiconductors","power-supplies","accessories","passive-components","electromechanical"]
		for p in pages:
			url1 = 'https://www.lankatronics.com/' + p +'.html'
			yield scrapy.Request(url = url1, callback = self.parse_page)
	
	def parse_page(self, response):
		#https://www.lankatronics.com/development-tools.html?p=2
		url = response.url
		for i in range(1,6):
			url1 = url+'?p='+str(i)
			yield scrapy.Request(url1, callback=self.parse_cat)

	def parse_cat(self, response):
		print('url is ' + response.request.url + ' correct url')
		for href in response.xpath('//a[@class="product-item-link"]/@href').extract():
		    print('Href is' + str(href) + 'href is working')
		    url2 = href
		    yield scrapy.Request(url = url2, callback = self.parse_item)

	def parse_item(self, response):	
		title = response.xpath('//1/span/text()').extract_first()
		#//*[@id="product-price-4117"]/span
		print('dddddddddddddddd')
		#//*[@id="maincontent"]/div/div/div/div/div[2]/div[2]/div/div[1]/div/div[2]/div/div[1]/div[2]/div[2]
		price = price_str(str(response.xpath('//div[@class="price-box price-final_price"]/span/span/span/text()').extract_first()))
	
		if price is None:
			price=00.00
		else:
			price=price
       
		   
		#//*[@id="product.info.description"]/div/div/p[1]/text()
		description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",''.join(response.xpath('//*[@id="product.info.description"]/div/div/p[1]/text()').extract())) ).strip()
	

		#//*[@id="maincontent"]/div/div/div/div/div[2]/div[2]/div/div[1]/div/div[1]/div/div[2]/div[2]/div[2]/div[1]/div[3]/div[2]/img
		img = response.xpath('//*//*[@id="magnifier-item-0"]/@src').extract_first()
		#//*[@id="maincontent"]/div/div/div/div/div[2]/div[2]/div/div/div/div[1]/div/div[2]/div[2]/div[2]/div[1]/div[3]/div
		url = response.url
		location = 'online'
		#avilability = response.xpath('//*[@id="maincontent"]/div/div/div/div/div[2]/div[2]/div/div/div/div[2]/div/div[1]/div[2]/div[3]/div[1]/span/text()').extract_first()
		#condition ='New'


		yield {
				'title' : title,
				'price' : float(price),
				'description' : description,
				'img' : img,
				'url' : url,
				'location' : location
				#'avilability' : avilability,
				#'condition' : condition
		}
