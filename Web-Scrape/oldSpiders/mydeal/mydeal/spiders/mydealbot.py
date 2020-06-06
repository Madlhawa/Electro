# -*- coding: utf-8 -*-
import scrapy
import os
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time


class MydealbotSpider(scrapy.Spider):
    name = 'mydealbot'
    #allowed_domains = ['mydeal.lk']
    start_urls = ['https://mydeal.lk/electronics']
    dump_path = '../../../../data/mydeals.json'
    
    driver = webdriver.Firefox()
    driver.get(start_urls)

    if os.path.exists(dump_path):
        os.remove(dump_path)
        print('\x1b[0;33;41m' + 'File found & removed kapruka.json!' + '\x1b[0m')

    def parse(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-MAIN' + '\x1b[0m')
        print('\x1b[1;33;40m' + response.request.url + '\x1b[0m')
        for i in range(0,100):
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(3) 

        ilist = driver.find_elements(By.XPATH,'//div[@class="deal-wrapper"]/a/@href')
        print('\x1b[1;35;40m' + ilist + '\x1b[0m')

        #for url1 in ilist
            #print('\x1b[1;35;40m' + url1 + '\x1b[0m')
            #yield scrapy.Request(url1, callback = self.parse_page)

    #def parse_page(self, response):
        #print('\x1b[1;30;43m' + 'RUNNING-PAGE' + '\x1b[0m')
        #print('\x1b[1;33;40m' + response.request.url + '\x1b[0m')  
        #for href in response.xpath('//div[@class="deal-wrapper"]/a/@href'):
            #url2 = href.extract()
            #print('\x1b[1;35;40m' + url2 + '\x1b[0m')
            #yield scrapy.Request(url = url2, callback = self.parse_item)
    def parse_item(self, response):
        print('\x1b[1;30;43m' + 'RUNNING-ITEM' + '\x1b[0m')
        print('\x1b[1;33;40m' + response.request.url + '\x1b[0m')
        title = response.xpath('//*[@id="deal-title"]/text()[2]').extract_first()
        print('\x1b[6;30;42m' + str(title)  + '\x1b[0m')
        yield {
                'title' : title
        }
