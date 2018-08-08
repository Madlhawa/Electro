# -*- coding: utf-8 -*-
import scrapy

class SouqSpider(scrapy.Spider):
    name = "Souq"
    start_urls = ["http://deals.souq.com/ae-en/"]

    def parse(self, response):
        for href in response.css('.itemTitle a::attr(href)'):
            url = href.extract()
            yield scrapy.Request(url, callback=self.parse_item)

    def parse_item(self, response):
        original_price = -1
        savings=0
        discounted = False
        #seller_rating = response.css('.vip-product-info .stats .inline-block small::text'). extract()[0]
        #seller_rating = int(filter(unicode.isdigit,seller_rating))
        
        #if response.css('.vip-product-info .subhead::text').extract():
            #original_price = response.css('.vip-product-info .subhead::text').extract()[0].replace("AED", "")
            #discounted = True
            #savings = response.css('.vip-product-info .message .noWrap::text').extract()[0].replace("AED", "")

        yield {
            'Category': response.css('.small-12.columns.product-title a::text').extract()[1],
            'Title': response.css('.small-12.columns.product-title  h1::text').extract()[0]
            #'Category': response.css('.product-title h1+ span a+ a::text').extract()[0],
            #'OriginalPrice': original_price,
            #'CurrentPrice': response.css('.vip-product-info .price::text').extract()[0].replace(u"\xa0", ""),
            #'Discounted': discounted,
            #'Savings': savings,
            #'SoldBy': response.css('.vip-product-info .stats a::text').extract()[0],
            #'SellerRating': seller_rating,
            #'Url': response.url
        }
