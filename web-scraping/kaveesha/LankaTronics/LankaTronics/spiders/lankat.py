# -*- coding: utf-8 -*-
import re
import os
import scrapy
import unicodedata
from money_parser import price_str


class LankatSpider(scrapy.Spider):
    name = 'lankat'
    # allowed_domains = ['https://www.lankatronics.com/']
    start_urls = ['https://www.lankatronics.com/']
    dump_path = '../../../../data/lankatronics.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        pages = ["development-tools", "top-brands", "modules-sensors", "robot-accessories", "semiconductors","power-supplies", "accessories", "passive-components", "electromechanical"]
        for p in pages:
            url1 = 'https://www.lankatronics.com/' + p + '.html'
            print('\x1b[1;35;40m' + 'Now searching  ' + str(p) + '!' + '\x1b[0m')
            yield scrapy.Request(url=url1, callback=self.parse_page)

    def parse_page(self, response):
        url1 = response.request.url
        print('\x1b[1;30;43m' + 'RUNNING-PAGE' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        pageurls = response.xpath('//div[@class="pages"]/ul/li/a/@href').extract()  # type: urls of page numbers
        print('\x1b[6;30;45m' + url1 + '\x1b[0m')
        print('\x1b[6;30;45m' + str(pageurls[-1]) + '\x1b[0m')
        currentpageno = response.xpath('//div[@class="pages"]/ul/li[@class="item current"]/strong/span[2]/text()').extract_first()
        lastpageno = response.xpath('//div[@class="pages"]/ul/li/*/span[2]/text()').extract()[-1]
        if currentpageno == lastpageno:
            print('\x1b[0;33;41m' + 'Page no MATCHED!' + '\x1b[0m')
            print('\x1b[6;30;45m' + str(lastpageno) + ' inside the if(url=lastpageurl)' + '\x1b[0m')
            for i in range(1, int(lastpageno) + 1):
                url2 = url1[:-2] + str(i)
                print('\x1b[1;35;40m' + 'Inside the for loop : ' + url2 + '\x1b[0m')
                yield scrapy.Request(url=url2, callback=self.parse_cat)
        else:
            yield scrapy.Request(url=pageurls[-2], callback=self.parse_page)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        for href in response.xpath('//a[@class="product-item-link"]/@href').extract():
            print('Href is' + str(href) + 'href is working')
            yield scrapy.Request(url=href, callback=self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;35;40m' + response.request.url + '\x1b[0m')
        title = response.xpath('//h1[@class="page-title"]/span/text()').extract_first()
        price = price_str(str(response.xpath('//span[@class="price"]/text()').extract_first()))
        if price is None:
            price = 00.00
        else:
            price = price
        description = re.sub('\s+', ' ', unicodedata.normalize("NFKD", ''.join(response.xpath('//div[@class="product attribute description"]/div//text()').extract()))).strip()
        img ='None'
        url = response.url
        location = 'online'
        condition = 'New'
        avilability = response.xpath('//div[@title="Availability"]/span/text()').extract_first()
        print('\x1b[6;30;42m' + title + '\x1b[0m')
        print('\x1b[6;30;42m' + str(price) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(img) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(url) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(avilability) + '\x1b[0m')
        yield {
            'title': title,
            'price': float(price),
            'description': description,
            'img': img,
            'url': url,
            'location': location,
            'condition': condition
            # 'avilability' : avilability,
        }
