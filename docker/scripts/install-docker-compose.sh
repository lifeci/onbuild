#/bin/bash
#DockerComposeV=$2;
printf "\nGonna install:\tDockerComposeV: $DockerComposeV \n\n"
#install docker-compos
curl -L https://github.com/docker/compose/releases/download/${DockerComposeV}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

#postIntall: https://docs.docker.com/engine/installation/linux/linux-postinstall/#chkconfig
#groupadd docker --force
#usermod -aG docker $USER
#logoff
