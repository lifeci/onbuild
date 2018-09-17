#ARG BuildNo
#FROM lifeci/onbuild:base${BuildNo}
FROM alpine:3.8
MAINTAINER rj-lifeci
ARG AZURE_CLI_VERSION="2.0"
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo
RUN apk --update add sudo python py-pip openssl ca-certificates;
RUN apk --update add --virtual build-dependencies python-dev \
    libffi-dev openssl-dev build-base; \
    pip install --global --upgrade pip azure-cli==2.0.45; \
    apk del build-dependencies python-dev libffi-dev build-base gcc;\
    rm -rf /var/cache/apk/*
#RUN azure-cli --help
#RUN az --completion
#RUN azure --completion >> ~/azure.completion.sh && \
#    echo 'source ~/azure.completion.sh' >> ~/.bashrc && \
#    az telemetry --disable



# switch to regular account
ARG GrpName=agroup
ARG GrpUID=1100
ARG UsrName=auser
ARG UsrUID=1000
RUN addgroup -g ${GrpUID} ${GrpName}; adduser -D -u ${UsrUID} ${UsrName} -G ${GrpName};
USER ${UsrName}
#RUN  az --version
CMD printf "USAGE:\t docker run --rm lifeci/onbuild:azure$(cat ./BuildNo) az --help\n"
