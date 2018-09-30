#!/bin/bash
source /home/madhawa242/python-environments/scrapy_env/bin/activate
cd web-scraping/madhawa/kaprukascraper/kaprukascraper/;
scrapy crawl kapruka;
cd ../../buyabans/buyabans/;
scrapy crawl buyabansbot;
cd ../../clicknshopScraper/clicknshopScraper/;
scrapy crawl clicknshop;
cd ../../scionscraper/scionscraper/;
scrapy crawl scion;
cd ../../daraz/daraz/;
scrapy crawl darazbot;
cd ../../ikman/ikman;
scrapy crawl ikmanbot;
cd ../../../kaveesha/LankaTronics/LankaTronics;
scrapy crawl lankat;
git pull;
git add .;
git commit -a -m "Automated scrape";
git push;
