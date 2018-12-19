#!/bin/bash

SQLpackageMediaURL=https://sqlpackage.blob.core.windows.net/preview/sqlpackage-linux-x64-150.4240.1.zip
#https://go.microsoft.com/fwlink/?linkid=2044263
curl -L $SQLpackageMediaURL --output /tmp/sqlpackage.zip

apt update; apt install -y --no-install-recommends unzip
#sudo apt-get install libuwind8

mkdir -p /opt/sqlpackage; cd /opt/sqlpackage
unzip /tmp/sqlpackage.zip

chmod +x /opt/sqlpackage/sqlpackage

echo 'export PATH="$PATH:/opt/sqlpackage"' >> /etc/bash.bashrc
source /etc/bash.bashrc
