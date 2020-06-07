#!/bin/bash
cd ~/searchit/data;
git pull;
cd /opt/solr;
./bin/post -c electro -d "<delete><query>*:*</query></delete>"
./bin/post -c electro ~/searchit/data/*.json
