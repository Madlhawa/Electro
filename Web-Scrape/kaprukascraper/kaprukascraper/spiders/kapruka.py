# -*- coding: utf-8 -*-
import re
import os
import scrapy
import unicodedata
from money_parser import price_str


class KaprukaSpider(scrapy.Spider):
    name = 'kapruka'
    #allowed_domains = ['www.kapruka.com/shops/specialGifts/spotlights.jsp?t=electronics']
    start_urls = ['https://www.kapruka.com/shops/specialGifts/spotlights.jsp?t=electronics']
    dump_path = '../../../data/kapruka.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed kapruka.json!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        for href in response.xpath("//ul[@class='sidebar-na']/li/a/@href"):
            url1 = href.extract()
            yield scrapy.Request(url = url1, callback = self.parse_type)

    def parse_type(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        for href in response.xpath('//*[@id="parentHorizontalTab"]/ul/li/a/@href'):
            url1 = href.extract()
            yield scrapy.Request(url = url1, callback = self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        for href in response.xpath('//ul[@class="pagination"]/li/a/@href'):
            url2 = 'https://www.kapruka.com'+href.extract()
            yield scrapy.Request(url = url2, callback = self.parse_page)

    def parse_page(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-PAGE' + '\x1b[0m')
        for href in response.xpath('/html/body/div[4]/div/div[2]/div/div[1]/div/div[4]/ul/li/div/a[1]/@href'):
            url3 = 'https://www.kapruka.com'+href.extract()
            yield scrapy.Request(url = url3, callback = self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        
        title = response.xpath('/html/body/div[4]/div/div[2]/div/div[1]/div/form/div[2]/div/div[2]/div/h2/text()').extract_first()
        #category = response.xpath('/html/body/div[4]/div/div[2]/div/div[1]/div/ol/li[2]/a/span/text()').extract_first()
        img = response.xpath('//*[@id="view-product"]/img/@src').extract_first()
        url = response.url
        #price = response.xpath('//div[@class="price"]/strong/text()').extract_first()
        price = ''.join(re.findall(r'\d+', response.xpath('//div[@class="price"]/strong/text()').extract_first()))
        #description = response.xpath('//div[@class="info-wrap"]/*/ul/li/text()').extract()
        description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",''.join(list(response.xpath('//div[@class="info-wrap"]/*/ul/li/text()').extract()))) ).strip()
        location = 'online'
        
        print('\x1b[6;30;42m' + title  + '\x1b[0m')
        #print('\x1b[6;30;42m' + category  + '\x1b[0m')
        print('\x1b[6;30;42m' + price  + '\x1b[0m')
        print('\x1b[6;30;42m' + description  + '\x1b[0m')
        if img is not None:
            print('\x1b[6;30;42m' + img  + '\x1b[0m')
        print('\x1b[6;30;42m' + url  + '\x1b[0m')

        yield {
            'title' : title,
            'price' : float(price),
            'description' : description,
            #'category' : category,
            'img' : img,
            'url' : url,
            'location' : location,
            'store' : "Kapruka",
            'condition' : "New"
        }
