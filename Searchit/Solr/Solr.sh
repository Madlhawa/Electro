#Create core
/opt/bitnami/apache-solr/server/solr/reviewCore/

sudo mkdir /opt/bitnami/apache-solr/server/solr/reviewCore
sudo echo "name=reviewCore" > /opt/bitnami/apache-solr/server/solr/reviewCore/core.properties
sudo cp -r /opt/bitnami/apache-solr/server/solr/configsets/_default/conf/ /opt/bitnami/apache-solr/server/solr/reviewCore/

sudo ./bin/solr create -c CORE1 -p 8983

#------------------------------------------------------

cd /opt/bitnami/apache-solr/server/solr
sudo -u solr mkdir wsu
sudo -u solr cp -r ./configsets/_default/conf* ./wsu/
ls

#post documents
cd /opt/bitnami/apache-solr/
sudo -u solr ./bin/post -c wsu /home/rsa-key-20191214/Hotel_Reviews.csv
sudo -u solr ./bin/post -c wsu /home/rsa-key-20191214/Hotel_Reviews_predicted.csv 

#removing authentication from bitnami solr
cd /opt/bitnami/apache-solr/conf
sudo -u solr vi solr.conf

#remove older documents
cd /opt/bitnami/apache-solr/
sudo -u solr ./bin/post -c wsu -d "<delete><query>*:*</query></delete>"
