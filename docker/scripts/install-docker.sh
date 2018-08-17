#/bin/bash
#DockerV=$1;
printf "\nGonna install:\tDockerV: $DockerV \n\n"
# update repo
apt-get update
apt-get install --no-install-recommends -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update

apt-cache show docker-ce |  grep 'Version'
apt-get install --no-install-recommends -y \
    docker-ce=$DockerV

#postIntall: https://docs.docker.com/engine/installation/linux/linux-postinstall/#chkconfig
#groupadd docker --force
#usermod -aG docker $USER
#logoff
