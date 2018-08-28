#ARG CIRCLE_BUILD_NUM
#FROM lifeci/onbuild:base${CIRCLE_BUILD_NUM}
FROM alpine:3.8
MAINTAINER rj-lifeci
ARG AnsibleV=2.6.1
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo
RUN  apk --update add sudo python py-pip openssl ca-certificates; \
     apk --update add --virtual build-dependencies python-dev \
     libffi-dev openssl-dev build-base; \
     pip install --upgrade pip cffi ansible==$AnsibleV; \
     apk del build-dependencies python-dev libffi-dev build-base; \
     rm -rf /var/cache/apk/*
# switch to regular account
ARG GrpName=agroup
ARG GrpUID=1100
ARG UsrName=auser
ARG UsrUID=1000
RUN addgroup -g ${GrpUID} ${GrpName}; adduser -D -u ${UsrUID} ${UsrName} -G ${GrpName};
USER ${UsrName}
RUN  whoami;uname -a;
CMD printf "USAGE:\t docker run --rm lifeci/onbuild:ansible$(cat ./BuildNo) ansible --help\n"
