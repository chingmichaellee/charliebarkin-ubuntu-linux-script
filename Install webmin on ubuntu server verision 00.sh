#!/bin/bash

## This script is use for installing Webmin on Ubuntu Server
## Version 0.01

# Install Curl
sudo apt install curl -y

# Add Repository to the system

echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin2.list
curl http://www.webmin.com/jcameron-key.asc | sudo apt-key add -

# Update Repository and install webmin
sudo apt-get update
sudo apt-get install webmin -y



