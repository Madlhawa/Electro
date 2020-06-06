# -*- coding: utf-8 -*-
import re
import os
import scrapy
import unicodedata
from money_parser import price_str


class LaabaibotSpider(scrapy.Spider):
    name = 'laabaibot'
    #allowed_domains = ['laabai.lk/shop']
    start_urls = ['http://www.laabai.lk/shop/']
    dump_path = '../../../data/laabai.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        for  i in range(30):
            url1="https://www.laabai.lk/shop/page/"+str(i)+"/"
            print('\x1b[1;35;40m' + url1 + '\x1b[0m')
            yield scrapy.Request(url=url1, callback=self.parse_page)

    def parse_page(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-PAGE' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        for url2 in response.xpath("//p[@class='name product-title']/a/@href").extract():
            print('\x1b[1;35;40m' + url2 + '\x1b[0m')
            yield scrapy.Request(url=url2, callback=self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        title=response.xpath("//h1[@class='product-title entry-title']/text()").extract_first()
        price = price_str(response.xpath("//span[@class='woocommerce-Price-amount amount']/text()").extract_first())
        description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",' '.join(response.xpath("//div[@class='panel entry-content active']/ul/li/text()").extract())) ).strip()
        img = response.xpath("//img[@class='wp-post-image']/@src").extract_fist()
        url = response.url
        location = 'online'
        condition = 'New'
        #availability = 

        print('\x1b[6;30;42m' + title + '\x1b[0m')
        print('\x1b[6;30;42m' + str(price)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(img) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(url) + '\x1b[0m')

        yield {
                'title': title,
                'price': float(price),
                'description': description,
                'img': img,
                'url': url,
                'location': location,
                'condition': condition,
                'store': 'Laabai'
        }
