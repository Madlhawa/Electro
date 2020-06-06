# -*- coding: utf-8 -*-
import re
import os
import scrapy
import unicodedata
from money_parser import price_str


class MydealbotSpider(scrapy.Spider):
    name = 'mydealbot'
    #llowed_domains = ['www.mydeal.lk']
    start_urls = ['http://www.mydeal.lk/']
    dump_path = '../../../data/mydeal.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        for url1 in response.xpath("//ul[@id='departments-list']/li/a/@href").extract():
            url1= url1+'?page=2'
            print('\x1b[1;35;40m' + url1 + '\x1b[0m')
            yield scrapy.Request(url=url1, callback=self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        for url2 in response.xpath("//ul[@class='pagination']/li/a/@href").extract()[1:-1]:
            print('\x1b[1;35;40m' + url2 + '\x1b[0m')
            yield scrapy.Request(url=url2, callback=self.parse_page)

    def parse_page(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-PAGE' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        for url3 in response.xpath("//h4[@class='product-name']/a/@href").extract():
            print('\x1b[1;35;40m' + url3 + '\x1b[0m')
            yield scrapy.Request(url=url3, callback=self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')

        title = re.sub('\s+', ' ', unicodedata.normalize("NFKD", response.xpath("//div[@id='product-information']/h2/text()").extract_first())).strip()
        price = price_str(response.xpath("//div[@class='price']/text()").extract_first())
        description = re.sub('\s+', ' ', unicodedata.normalize("NFKD", '. '.join(response.xpath("//div[@class='panel-body']/table/tbody/tr/td[2]/text()").extract()))).strip()
        img = response.xpath("//div[@class='image-hero']/img/@src").extract_first()
        url = response.request.url
        location = 'online'
        condition = 'New'
        #availability = response.xpath("//div[@id='product-subheading']/div/div[4]/span[2]/text()").extract_first()
        
        if price is None:
            price = 00.00

        print('\x1b[6;30;42m' + title + '\x1b[0m')
        print('\x1b[6;30;42m' + str(price) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(img) + '\x1b[0m')

        yield {
                'title': title,
                'price': float(price),
                'description': description,
                'img': img,
                'url': url,
                'location': location,
                'condition': condition,
                'store': 'Mydeal'
        }
