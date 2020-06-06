# -*- coding: utf-8 -*-
import scrapy


class BuyonlinebotSpider(scrapy.Spider):
    name = 'buyonlinebot'
    #allowed_domains = ['buyonline.lk']
    start_urls = ['https://buyonline.lk/']

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        for url1 in response.xpath("//div[@id='sp-vermegamenu']/ul/li/a/@href").extract():
            print('\x1b[1;35;40m' + 'Now searching  ' + str(url1) + '!' + '\x1b[0m')
            yield scrapy.Request(url=url1, callback=self.parse_cat)

    def parse_cat(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-CAT' + '\x1b[0m')
        print('\x1b[1;31;40m' + response.request.url + '\x1b[0m')
        noOfPages = response.xpath("//ul[@class='page-list clearfix text-sm-center']/li/a/@href").extract()[-2]
        print('\x1b[1;30;43m' + noOfPages + '\x1b[0m')
        if(noOfPages==None):
            noOfPages = 0
            url2 = response.request.url
            print('\x1b[1;35;40m' + noOfPages + '\x1b[0m')
            print('\x1b[1;35;40m' + url2 + '\x1b[0m')
        else:
            noOfPages = noOfPages[-2][:-1]
            print('\x1b[1;35;40m' + noOfPages + '\x1b[0m')
            #for page in range(noOfPages):
            url2 = response.request.url+'?page='
            print('\x1b[1;35;40m' + url2 + '\x1b[0m')
