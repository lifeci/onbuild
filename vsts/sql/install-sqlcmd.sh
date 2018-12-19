#!/bin/bash
#based on https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-2017#ubuntu

curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/9/prod.list | \
     tee /etc/apt/sources.list.d/msprod.list

apt update;
ACCEPT_EULA=y DEBIAN_FRONTEND=noninteractive \
apt install -y --no-install-recommends \
           mssql-tools unixodbc-dev locales

# Add UTF-8 support
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen;
locale-gen

# add to path
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> /etc/bash.bashrc
source /etc/bash.bashrc
