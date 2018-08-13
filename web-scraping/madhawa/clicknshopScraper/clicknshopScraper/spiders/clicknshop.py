# -*- coding: utf-8 -*-
import scrapy
import os
import glob


class ClicknshopSpider(scrapy.Spider):
    name = 'clicknshop'
    #allowed_domains = ['www.clicknshop.lk']
    start_urls = ['https://www.clicknshop.lk/electronics.html?limit=all']
    os_path = '../../../../data/'
    if os.path.exists('../../../../data/clicknshop.json'):
        os.remove('../../../../data/clicknshop.json')
        print('\x1b[0;33;41m' + 'file found & removed clicknshop.json' '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        for href in response.xpath('//*[@class="category-products"]/ul/li[@class=" item"]/div/div/div[@class="actions-no hover-box"]/a/@href'):
            url = href.extract()
            yield scrapy.Request(url, callback=self.parse_item)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        Title = response.xpath('//span[@class="nameCont"]/text()').extract_first()
        Price = response.xpath('//span[@class="price"]/text()').extract()[1]
        Stock = response.xpath('//p[@class="availability in-stock"]/span/text()').extract_first()
        Warranty = response.xpath('//div[@class="ProductInfo warranty d-flex"]/span/text()').extract_first()
        Discription = list(response.xpath('//div[@id="pd1"]/ul/li/text()').extract())
        Specification = list(response.xpath('//*[@id="product-attribute-specs-table"]/tbody/tr[10]/td/text()').extract())
        img = response.xpath('//*[@id="image-0"]/@src').extract_first()
        url = response.url

        print('\x1b[6;30;42m' + Title + '\x1b[0m')
        print('\x1b[6;30;42m' + Price + '\x1b[0m')
        print('\x1b[6;30;42m' + str(Stock) + '\x1b[0m')
        print('\x1b[6;30;42m' + Warranty + '\x1b[0m')
        print('\x1b[6;30;42m' + str(Discription) + '\x1b[0m')
        print('\x1b[6;30;42m' + str(Specification) + '\x1b[0m')
        print('\x1b[6;30;42m' + img + '\x1b[0m')
        print('\x1b[6;30;42m' + url + '\x1b[0m')


        yield {
                'Title' : Title,
                'Price' : Price,
                'Stock' : Stock,
                'Warranty' : Warranty,
                'Discription' : Discription,
                'Specification' : Specification,
                'img' : img,
                'url' : url
        }
