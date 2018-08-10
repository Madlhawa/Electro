# -*- coding: utf-8 -*-
import scrapy
import os
import glob


class ScionSpider(scrapy.Spider):
    name = 'scion'
    #allowed_domains = ['www.scionelectronics.com']
    start_urls = ['http://scionelectronics.com/']
    if os.path.exists('../../../../data/scion.json') or os.path.exists('../../../../data/scion.csv'):
        for files in glob.glob("../../../../data/scion.json"):
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
        yield {
                'Title' : response.xpath('//h1[@class="product_title entry-title"]/text()').extract_first(),
                'title' : response.xpath('//h1[@class="product_title entry-title"]/text()').extract_first(),
                'price' : response.xpath('//p[@class="price"]/span/text()').extract_first(),
                'tags' : response.xpath('//div[@class="product_meta"]/span/a/text()').extract(),
                'discription' : response.xpath('//*[@id="tab-description"]/ul/li/text()').extract(),
                'img' : response.xpath('//div[@class="images"]/a/@href').extract_first(),
                'url' : response.url
        }
