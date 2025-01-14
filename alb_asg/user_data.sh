#!/bin/bash
sudo dnf install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
host_name=$HOSTNAME
sudo echo "<h1>Local-$host_name </h1>" > /var/www/html/index.html