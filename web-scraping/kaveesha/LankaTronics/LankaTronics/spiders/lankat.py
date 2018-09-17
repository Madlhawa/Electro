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
		title = response.xpath('//h1[@class="page-title"]/span/text()').extract_first()
		price = price_str(str(response.xpath('//span[@class="price"]/text()').extract_first()))
		if price is None:
			price=00.00
		else:
			price=price
		description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",''.join(response.xpath('//div[@class="product attribute description"]/div//text()').extract())) ).strip()
		img = response.xpath('//*//*[@id="magnifier-item-0"]/@src').extract_first()
		url = response.url
		location = 'online'
		condition ='New'
		#avilability = response.xpath('//*[@id="maincontent"]/div/div/div/div/div[2]/div[2]/div/div/div/div[2]/div/div[1]/div[2]/div[3]/div[1]/span/text()').extract_first()
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
