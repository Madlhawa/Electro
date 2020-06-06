# -*- coding: utf-8 -*-
import scrapy
import re
import os
import unicodedata


class MysoftlogicbotSpider(scrapy.Spider):
    name = 'mysoftlogicbot'
    #allowed_domains = ['mysoftlogic.lk']
    start_urls = ['https://mysoftlogic.lk/']

    dump_path = '../../../data/mysoftlogic.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')


    def parse(self, response):
        for href in response.xpath("//ul[@class='links']/li/a/@href"):
            url1 = href.extract()
            print(url1)
            url1 = 'https://mysoftlogic.lk' + url1
            yield scrapy.Request(url=url1, callback=self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        for href in response.xpath("//figcaption/a/@href"):
            url2 = href.extract()
            print(url2)
            url2 = 'https://mysoftlogic.lk' + url2
            yield scrapy.Request(url = url2, callback = self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        title = response.xpath('//div[@id="detail-content"]/h1/text()').extract_first()
        img = 'https://mysoftlogic.lk' + response.xpath('//img[@id="product_img_1"]/@src').extract_first()
        url = response.request.url
        price = 0.0
        description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",' '.join(response.xpath('//ol[@class="breadcrumb"]/li/a/text()').extract())) ).strip()

        print('\x1b[6;30;42m' + title  + '\x1b[0m')
        print('\x1b[6;30;42m' + img + '\x1b[0m')
        print('\x1b[6;30;42m' + url + '\x1b[0m')
        print('\x1b[6;30;42m' + description + '\x1b[0m')

        yield {
            'title': title,
            'price': float(price),
            'description': description,
            'img': img,
            'url': url,
            'location': "Online",
            'store': "Softlogic",
            'condition': "New"
        }