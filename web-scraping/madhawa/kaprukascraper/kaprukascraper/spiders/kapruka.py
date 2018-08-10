# -*- coding: utf-8 -*-
import scrapy
import os


class KaprukaSpider(scrapy.Spider):
    name = 'kapruka'
    #allowed_domains = ['www.kapruka.com/shops/specialGifts/spotlights.jsp?t=electronics']
    start_urls = ['https://www.kapruka.com/shops/specialGifts/spotlights.jsp?t=electronics']
    if os.path.exists('../../../data/kapruka.json'):
        os.remove('../../../data/kapruka.json')
        print('file found & removed kapruka.json')

    def parse(self, response):
        print('running -----------------------------------------|||||||||||||||||||||||||||||||||||||||||MAIN')
        for href in response.xpath('//*[@id="parentHorizontalTab"]/ul/li/a/@href'):
            url1 = 'https://www.kapruka.com'+href.extract()
            yield scrapy.Request(url = url1, callback = self.parse_cat)

    def parse_cat(self, response):
        print('running -----------------------------------------|||||||||||||||||||||||||||||||||||||||||cat')
        for href in response.xpath('//ul[@class="pagination"]/li/a/@href'):
            url2 = 'https://www.kapruka.com'+href.extract()
            yield scrapy.Request(url = url2, callback = self.parse_page)

    def parse_page(self, response):
        print('running -----------------------------------------|||||||||||||||||||||||||||||||||||||||||page')
        for href in response.xpath('/html/body/div[4]/div/div[2]/div/div[1]/div/div[4]/ul/li/div/a[1]/@href'):
            url3 = 'https://www.kapruka.com'+href.extract()
            yield scrapy.Request(url = url3, callback = self.parse_item)

    def parse_item(self, response):
        print('running -----------------------------------------|||||||||||||||||||||||||||||||||||||||||item')
        yield {
            'title' : response.xpath('/html/body/div[4]/div/div[2]/div/div[1]/div/form/div[2]/div/div[2]/div/h2/text()').extract_first(),
            'category' : response.xpath('/html/body/div[4]/div/div[2]/div/div[1]/div/ol/li[2]/a/span/text()').extract_first(),
            'img' : response.xpath('//*[@id="view-product"]/img/@src').extract_first(),
            'url' : response.url
        }
