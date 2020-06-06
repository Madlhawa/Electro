#!/bin/bash
cd ~/Web-Scrape;
git submodule init;
git submodule update;
cd ;
git clone git@github.com:Madlhawa/data.git;
sudo apt install python3-pip;
sudo python3 -m pip install --user virtualenv;
sudo pip install --upgrade pip;
sudo apt install python-pip;
sudo pip install --upgrade pip;
sudo python3 -m virtualenv env;
source env/bin/activate;
sudo apt-get install python-dev python-pip libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev;
sudo apt-get install python3 python3-dev;
sudo pip3 install scrapy;
sudo pip3 install money_parser;
sudo pip3 install service_identity --force --upgrade;
