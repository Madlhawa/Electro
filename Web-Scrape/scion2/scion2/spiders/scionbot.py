# -*- coding: utf-8 -*-
import scrapy
import re
import os
import scrapy
import unicodedata
from money_parser import price_str


class ScionbotSpider(scrapy.Spider):
    name = 'scionbot'
    #allowed_domains = ['scionelectronics.com']
    start_urls = ['http://scionelectronics.com/']
    dump_path = '../../../data/scion.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        for url1 in response.xpath('//*[@id="woocommerce_product_categories-2"]/ul/li/a/@href').extract():
            url1=url1+'?showproducts=1000'
            print('\x1b[1;35;40m' + url1 + '\x1b[0m')
            yield scrapy.Request(url = url1, callback = self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        for url2 in response.xpath('//a[@class="product-title"]/@href').extract():
            print('\x1b[1;35;40m' + url2 + '\x1b[0m')
            yield scrapy.Request(url2, callback=self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        title = response.xpath('//h1[@class="product_title entry-title"]/text()').extract_first() 
        price = price_str(response.xpath('//div[@class="product-price"]/p/span/text()').extract_first())
        description = response.xpath('//div[@class="product_meta"]/span/a/text()').extract() 
        img = response.xpath('//*[@id="product-image"]/div/@data-thumb').extract_first()
        url = response.request.url
        location = 'Malabe, Moratuwa, online'

        print('\x1b[6;30;42m' + title  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(price)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(img)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(url)  + '\x1b[0m')

        yield {
                'title' : title,
                'price' : float(price),
                'description' : description,
                'img' : img,
                'url' : url,
                'location' : location,
                'store' : "Scion",
                'condition': "New"
        }
