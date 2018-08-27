# -*- coding: utf-8 -*-
import scrapy
import os


class BuyabansbotSpider(scrapy.Spider):
    name = 'buyabansbot'
    #allowed_domains = ['www.buyabans.com/all-category']
    start_urls = ['https://buyabans.com/all-category']
    dump_path = '../../../../data/buyabans.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed ' + dump_path + '!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        for href in response.xpath('//*[@id="view-product-list"]/ul/li/a/@href'):
            print('\x1b[0;33;41m' + 'File found & removed ' + str(href) + '!' + '\x1b[0m')
            url1 = 'https://buyabans.com' + href.extract()
            yield scrapy.Request(url = url1, callback = self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        for href in response.xpath('//*[@id="filter-container"]/li/a/@href'):
            url2 = href.extract()
            yield scrapy.Request(url = url2, callback = self.parse_page)

    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        title = response.xpath('//*[@id="product"]/div/div[2]/h1/text()').extract_first()
        category = response.xpath('//*[@id="product"]/div/div[2]/p[1]/text()').extract_first()
        img = response.xpath('//*[@id="product"]/div/div[1]/ul/div[1]/div/div[3]/li/a/img/@src').extract_first()
        url = response.url

        print('\x1b[6;30;42m' + title  + '\x1b[0m')
        print('\x1b[6;30;42m' + category  + '\x1b[0m')
        print('\x1b[6;30;42m' + img  + '\x1b[0m')
        print('\x1b[6;30;42m' + url  + '\x1b[0m')

        yield {
                'title' : title,
                'category' : category,
                'img' : img,
                'url' : url
        }
