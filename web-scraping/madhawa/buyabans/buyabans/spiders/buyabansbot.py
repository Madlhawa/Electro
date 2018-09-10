# -*- coding: utf-8 -*-
import scrapy
import os
import unicodedata
import re


class BuyabansbotSpider(scrapy.Spider):
    name = 'buyabansbot'
    #allowed_domains = ['www.buyabans.com/all-category']
    start_urls = ['https://buyabans.com/all-category']
    dump_path = '../../../../data/buyabans.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        #for href in response.xpath('//*[@id="view-product-list"]/ul/li/a/@href'):
        pages = ["air-conditioners","apple-products","tv","audio","computers","refrigerators","washing-machines","home-appliances","kitchen-appliances","small-appliances","mobile-phones","watch","pos-system"]
        for p in pages:
            print('\x1b[1;35;40m' + 'Now searching  ' + str(p) + '!' + '\x1b[0m')
            url1 = 'https://buyabans.com/item/list/' + p
            yield scrapy.Request(url = url1, callback = self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')  
        for href in response.xpath('//*[@id="filter-container"]/li/a/@href'):
            url2 = href.extract()
            yield scrapy.Request(url = url2, callback = self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        title = response.xpath('//*[@id="product"]/div/div[2]/h1/text()').extract_first()
        price = response.xpath('//*[@id="item_price"]/text()').extract_first()
        description1 = response.xpath('//*[@id="product-detail"]/*//text()').extract()
        description2 = unicodedata.normalize("NFKD",''.join(description1))
        description = re.sub( '\s+', ' ', description2 ).strip()
        img = response.xpath('//*[@id="zoom_03"]/@src').extract_first()
        url = response.url
        location = 'online'

        print('\x1b[6;30;42m' + title  + '\x1b[0m')
        print('\x1b[6;30;42m' + price  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(img)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(url)  + '\x1b[0m')

        yield {
                'title' : title,
                'price' : price,
                'description' : description,
                'img' : img,
                'url' : url,
                'location' : location
        }
