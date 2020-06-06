#!/bin/bash
source my_env/bin/activate
cd ~/ikmanscraper/ikman/ikman/
scrapy crawl ikmanbot
cd ../../
git add .
git commit -a -m "automated commit"
git push
