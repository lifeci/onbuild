#!/bin/sh
AWSiamV=$1

#aws-iam is required to access to EKS base on user
curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/${AWSiamV}/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator; \
    mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
