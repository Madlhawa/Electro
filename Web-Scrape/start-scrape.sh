#!/bin/bash
source ~/env/bin/activate
cd Web-Scrape/kaprukascraper/kaprukascraper/;
#scrapy crawl kapruka;
cd ../../buyabans/buyabans/;
#scrapy crawl buyabansbot;
cd ../../clicknshopScraper/clicknshopScraper/;
#scrapy crawl clicknshop;
cd ../../scionscraper/scionscraper/;
#scrapy crawl scion;
#cd ../../ikman/ikman;
#scrapy crawl ikmanbot;
cd ../../LankaTronics/LankaTronics;
#scrapy crawl lankat;
cd ../../mysoftlogic/mysoftlogic;
#scrapy crawl mysoftlogicbot;
cd ../../../data;
pwd;
git pull;
git add .;
git commit -a -m "Automated scrape";
git push;
pwd;
echo "above";
cd /opt/bitnami/apache-solr;
#./bin/post -c electro102 -d "<delete><query>*:*</query></delete>"
#./bin/post -c electro102 ~/searchit/data/*.json
#./bin/post -c electro102 ~/searchit/ikmanscraper/data/*.json

