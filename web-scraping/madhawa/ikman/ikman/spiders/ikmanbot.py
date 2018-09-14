# -*- coding: utf-8 -*-
import scrapy
import os
import re
import unicodedata
from money_parser import price_str


class IkmanbotSpider(scrapy.Spider):
    name = 'ikmanbot'
    #allowed_domains = ['ikman.lk/en/ads/sri-lanka/electronics']
    start_urls = ['https://ikman.lk/en/ads/sri-lanka/electronics/']
    dump_path = '../../../../data/ikman.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        url = response.url
        for i in range(1,101):
            url1 = url+'?page='+str(i)
            print('\x1b[1;35;40m' + url1 + '\x1b[0m')
            yield scrapy.Request(url1, callback=self.parse_page)

    def parse_page(self, response):
        for href in response.xpath('//div[@class="ui-item"]/div/a/@href').extract():
            print('\x1b[1;35;40m' + str(href) + '\x1b[0m')
            url2 = 'https://ikman.lk'+ href
            yield scrapy.Request(url2, callback=self.parse_item)

    def parse_item(self, response):
        title = response.xpath('//div[@class="item-top col-12 lg-8"]/h1/text()').extract_first()
        location = response.xpath('//div[@class="item-top col-12 lg-8"]/p/span[@class="location"]/text()').extract_first()
        description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",''.join(response.xpath('//div[@class="item-description"]/*/text()').extract())) ).strip()
        price = price_str(response.xpath('//div[@class="ui-price-tag"]/span[@class="amount"]/text()').extract_first())
        url = response.url
        img = "na"
        condition = response.xpath('//div[@class="item-properties"]/dl/dd/text()').extract_first()
        print('\x1b[6;30;42m' + str(title)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(location)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(price)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(url)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(condition)  + '\x1b[0m')
        yield {
                'title' : title,
                'price' : float(price),
                'description' : description,
                'img' : img,
                'url' : url,
                'location' : location,
                'store' : "Ikman",
                'condition' : condition
        }



