#!/bin/sh
#sudo apt-get install -y python
#sudo apt-get install -y python-pip
#sudo apt-get install -y ansible
sudo apt-get update
sudo apt-get install -y nginx
echo "<html><h1>Hello from harshvardhan</h2></html>" > /var/www/html/index.html
sudo service restart nginx
