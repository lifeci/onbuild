ARG BasedOn=vsts
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG K8sCliV
##$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8sCliV}/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl; \
    mv ./kubectl /usr/local/bin/kubectl

#aws-iam is required to access to EKS base on user
ARG AWSiamV
RUN curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/${AWSiamV}/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator; \
    mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

RUN which aws-iam-authenticator kubectl
