#!/bin/sh
K8sCliV=$1

curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8sCliV}/bin/linux/amd64/kubectl
#wget -t 10 -O ./kubectl https://storage.googleapis.com/kubernetes-release/release/${K8sCliV}/bin/linux/amd64/kubectl
chmod +x ./kubectl;
mv ./kubectl /usr/local/bin/kubectl;

kubectl version --client=true
