# -*- coding: utf-8 -*-
import scrapy
import os


class DarazbotSpider(scrapy.Spider):
    name = 'darazbot'
    #allowed_domains = ['daraz.lk']
    start_urls = ['https://www.daraz.lk/']
    dump_path = '../../../../data/daraz.json'

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed' + dump_path + '\x1b[0m')

    def parse(self, response):
        for href in response.xpath('//*[@id="menuFixed"]/ul/li/a/@href'):
            url1 = href.extract()
            print('\x1b[1;35;40m' + url1 + '\x1b[0m')
            yield scrapy.Request(url = url1, callback = self.parse_category)

    def parse_category(self, response):
        pages = response.xpath('//section[@class="pagination"]/ul/li/a/@title').extract()
        totpages = pages[-2]
        print('\x1b[1;35;40m' + 'totpages : ' + totpages + '\x1b[0m')
        pagelink = response.xpath('//section[@class="pagination"]/ul/li/a/@href').extract_first()
        for i in range(1,int(totpages)+1):
            url2 = pagelink + '?page=' + str(i)
            print('\x1b[1;35;40m' + 'pagelinks : ' + url2 + '\x1b[0m')
            yield scrapy.Request(url = url2, callback = self.parse_page)

    def parse_page(self, response):
        for href in response.xpath('//section[@class="products"]/div/a/@href'):
            url3 = href.extract()
            print('\x1b[1;35;40m' + url3 + '\x1b[0m')
            yield scrapy.Request(url = url3, callback = self.parse_item)

    def parse_item(self, response):
        title = response.xpath('//h1[@class="title"]/text()').extract_first()
        price = response.xpath('//span[@class="price"]/span[@dir="ltr"]/@data-price').extract_first()
        img = response.xpath('//div[@class="product-preview"]/img/@src').extract_first()
        description = response.xpath('/html/body/main/section[1]/div[2]/div[1]/div[5]/div[2]/ul/li/text()').extract()
        brand = response.xpath('//div[@class="sub-title"]/a/text()').extract_first()
        print('\x1b[6;30;42m' + str(title)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(price)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(img)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(description)  + '\x1b[0m')
        print('\x1b[6;30;42m' + str(brand)  + '\x1b[0m')
        yield{
                    'title':title,
                    'price':price,
                    'img':img,
                    'description':description,
                    'brand':brand
        }
