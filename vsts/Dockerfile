ARG BasedOn=base
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
MAINTAINER rj-lifeci
#ENV DEBIAN_FRONTEND=noninteractive
#RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes
RUN apt update \
        && apt install -y --no-install-recommends \
        software-properties-common \
        && apt install -y --no-install-recommends \
        apt-utils \
        git \
        jq \
        libcurl3 \
        libicu57 \
        libunwind8 \
        netcat \
        && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
        && apt install -y --no-install-recommends git-lfs \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /etc/apt/sources.list.d/*

# Accept the TEE EULA
RUN mkdir -p "/root/.microsoft/Team Foundation/4.0/Configuration/TEE-Mementos" \
 && cd "/root/.microsoft/Team Foundation/4.0/Configuration/TEE-Mementos" \
 && echo '<ProductIdData><eula-14.0 value="true"/></ProductIdData>' > "com.microsoft.tfs.client.productid.xml"

WORKDIR /vsts

COPY ./*.sh ./
RUN chmod +x start.sh; chmod 777 -R /vsts
RUN ls -la  /vsts

STOPSIGNAL SIGTERM
#  SIGTERM -> exit 143' TERM | SIGINT -> exit 130' INT
ENTRYPOINT ./start.sh
