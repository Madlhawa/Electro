# -*- coding: utf-8 -*-
import re
import os
import glob
import scrapy
import unicodedata
from money_parser import price_str


class ScionSpider(scrapy.Spider):
    name = 'scion'
    #allowed_domains = ['www.scionelectronics.com']
    start_urls = ['http://scionelectronics.com/']
    dump_path = '../../../../data/scion.json'

    if os.path.exists(dump_path) or os.path.exists('../../../../data/scion.csv'):
        for files in glob.glob(dump_path):
            os.remove(files)
            print('file found & removed ',files)

    def parse(self, response):
        baseUrl = response.url
        pages = response.xpath('//*[@id="content-shop"]/nav/ul/li[8]/a/text()').extract()
        for pageNo in range(1, int(pages[0])):
            link = baseUrl+'page/'+str(pageNo)+'/'
            print(link)
            yield scrapy.Request(link, self.parse_page)
    
    def parse_page(self, response):
        print('-------------------------Now running parse_page -------------------------')
        for href in response.xpath('//*[@id="content-shop"]/ul/li/div/a/@href'):
            url1 = href.extract()
            yield scrapy.Request(url = url1, callback = self.parse_item)

    def parse_item(self, response):
        print('-------------------------Now running parse_item-----------------------------')
        description = re.sub( '\s+', ' ', unicodedata.normalize("NFKD",' '.join(response.xpath('//*[@id="tab-description"]/ul/li/text()').extract()))).strip(),

        yield {
                'title' : re.sub( '\s+', ' ', unicodedata.normalize("NFKD",''.join(list(response.xpath('//h1[@class="product_title entry-title"]/text()').extract_first()))) ).strip(),
                'price' : float(''.join(re.findall(r'\d+', response.xpath('//p[@class="price"]/span/text()').extract_first()))),
                #'tags' : response.xpath('//div[@class="product_meta"]/span/a/text()').extract(),
                'description' : description,
                'img' : response.xpath('//div[@class="images"]/a/@href').extract_first(),
                'url' : response.url,
                'location' : 'Malabe',
                'store' : "Scion",
                'condition' : "New"
        }
       
