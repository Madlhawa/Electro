# -*- coding: utf-8 -*-
import scrapy
import os
import glob


class ClicknshopSpider(scrapy.Spider):
    name = 'clicknshop'
    allowed_domains = ['www.clicknshop.lk']
    start_urls = ['https://www.clicknshop.lk/electronics.html?limit=all']
    if os.path.exists('../../../../data/clicknshop.json'): #or os.path.exists('../../../../data/clicknshop.csv'):
        for files in glob.glob("../../../../data/clicknshop.json"):
            os.remove(files)
            print('file found & removed ',files)

    def parse(self, response):
        for href in response.xpath('//*[@class="category-products"]/ul/li[@class=" item"]/div/div/div[@class="actions-no hover-box"]/a/@href'):
            url = href.extract()
            yield scrapy.Request(url, callback=self.parse_item)

    def parse_item(self, response):
        yield {
                'Title' : response.xpath('//span[@class="nameCont"]/text()').extract_first(),
                'Price' : response.xpath('//span[@class="price"]/text()').extract()[1],
                'Stock' : response.xpath('//p[@class="availability in-stock"]/span/text()').extract(),
                'Warranty' : response.xpath('//div[@class="ProductInfo warranty d-flex"]/span/text()').extract(),
                'Discription' : response.xpath('//div[@id="pd1"]/ul/li/text()').extract(),
                'Specifications' : response.xpath('//*[@id="product-attribute-specs-table"]/tbody/tr[10]/td/text()').extract(),
                'url' : response.url
        }
