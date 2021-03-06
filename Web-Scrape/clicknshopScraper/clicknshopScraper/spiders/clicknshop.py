# -*- coding: utf-8 -*-
import re
import os
import scrapy
import unicodedata
from money_parser import price_str


class ClicknshopSpider(scrapy.Spider):
    name = 'clicknshop'
    #allowed_domains = ['www.clicknshop.lk']
    start_urls = ['https://www.clicknshop.lk']
    os_path = '../../../data/'
    if os.path.exists('../../../data/clicknshop.json'):
        os.remove('../../../data/clicknshop.json')
        print('\x1b[0;33;41m' + 'file found & removed clicknshop.json' '\x1b[0m')
    
    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        #for href in response.xpath('//*[@id="view-product-list"]/ul/li/a/@href'):
        pages = ["home-kitchen","phone-tabs","tv","computers","gifts-flowers","automobile-accessories","beauty-grooming","baby-kids","health-fitness-13","fashion-accessories","other"]
        for p in pages:
            print('\x1b[1;35;40m' + 'Now searching  ' + str(p) + '!' + '\x1b[0m')
            url1 = 'https://www.clicknshop.lk/' + p +'.html?limit=all'
            yield scrapy.Request(url = url1, callback = self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        for href in response.xpath('//*[@class="category-products"]/ul/li[@class=" item"]/div/div/div[@class="actions-no hover-box"]/a/@href'):
            url = href.extract()
            yield scrapy.Request(url, callback=self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        Title = response.xpath('//span[@class="nameCont"]/text()').extract_first()
        #Price = response.xpath('//span[@class="price"]/text()').extract()[1]
        Price = price_str(response.xpath('//span[@class="price"]/text()').extract()[1])
        #description = list(response.xpath('//*[@id="product-attribute-specs-table"]/tbody/tr[10]/td/text()').extract())
        description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",''.join(list(response.xpath('//*[@id="product-attribute-specs-table"]/tbody/tr[10]/td/text()').extract()))) ).strip()
        img = response.xpath('//*[@id="image-0"]/@src').extract_first()
        url = response.url
        location = 'online'
        print('\x1b[6;30;42m' + Title + '\x1b[0m')
        print('\x1b[6;30;42m' + str(Price) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description) + '\x1b[0m')
        print('\x1b[6;30;42m' + img + '\x1b[0m')
        print('\x1b[6;30;42m' + url + '\x1b[0m')
        print('\x1b[6;30;42m' + location + '\x1b[0m')
        #Stock = response.xpath('//p[@class="availability in-stock"]/span/text()').extract_first()
        #Warranty = response.xpath('//div[@class="ProductInfo warranty d-flex"]/span/text()').extract_first()
        #Discription = list(response.xpath('//div[@id="pd1"]/ul/li/text()').extract())
        #print('\x1b[6;30;42m' + str(Stock) + '\x1b[0m')
        #print('\x1b[6;30;42m' + Warranty + '\x1b[0m')
        #print('\x1b[6;30;42m' + str(Specification) + '\x1b[0m')
        
        yield {
                'title' : Title,
                'price' : float(Price),
                'description' : description,
                'img' : img,
                'url' : url,
                'location' : location,
                'store' : "ClicknShop",
                'condition' : "New"
        }
