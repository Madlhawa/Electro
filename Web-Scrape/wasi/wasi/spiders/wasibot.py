# -*- coding: utf-8 -*-
import re
import os
import scrapy
import unicodedata
from money_parser import price_str


class WasibotSpider(scrapy.Spider):
    name = 'wasibot'
    #allowed_domains = ['wasi.lk/shop']
    start_urls = ['http://wasi.lk/shop/']
    dump_path = '../../../data/wasi.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        noOfPages = int(response.xpath("//ul[@class='page-numbers']/li/a/text()").extract()[-2])
        for i in range(1,noOfPages+1):
            url1 = 'https://www.wasi.lk/shop/page/'+ str(i) + '/'
            print('\x1b[1;35;40m' + url1 + '\x1b[0m')
            yield scrapy.Request(url=url1, callback=self.parse_page)

    def parse_page(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-PAGE' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        for url2 in response.xpath('//div[@class="product-inner"]/a/@href').extract():
            print('\x1b[1;35;40m' + url2 + '\x1b[0m')
            yield scrapy.Request(url=url2, callback=self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        
        title = response.xpath('//div[@class="single-product-title"]/h1/text()').extract_first()
        price = 00.00
        description =  re.sub('\s+', ' ', unicodedata.normalize("NFKD", '. '.join(response.xpath('//*[@id="tab-description"]/ul/li/text()').extract()))).strip()
        description = description + " " + re.sub('\s+', ' ', unicodedata.normalize("NFKD", ''.join(response.xpath('////*[@id="tab-description"]/p/text()').extract()))).strip()
        img = response.xpath('//figure/div/a/@href').extract_first()
        url = response.request.url
        location = 'Colombo, online'
        condition = 'New'
        availability = 'na'

        if price is None:
            price = 00.00

        print('\x1b[6;30;42m' + title + '\x1b[0m')
        print('\x1b[6;30;42m' + str(price) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(img) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(url) + '\x1b[0m')
        #print('\x1b[6;30;42m' + str(avilability) + '\x1b[0m')

        yield {
            'title': title,
            'price': float(price),
            'description': description,
            'img': img,
            'url': url,
            'location': location,
            'condition': condition,
            'store': 'Wasi.lk'
            # 'avilability' : avilability,
        }
