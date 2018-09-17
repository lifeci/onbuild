#ARG CIRCLE_BUILD_NUM
FROM lifeci/onbuild:base${CIRCLE_BUILD_NUM}
MAINTAINER rj-lifeci
ARG AnsibleV=2.6.1
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo

RUN pip install --upgrade pip;
RUN pip install ansible==$AnsibleV;
#RUN  apk --update add sudo python py-pip openssl ca-certificates; \
#     apk --update add --virtual build-dependencies python-dev \
#     libffi-dev openssl-dev build-base; \
#     pip install --upgrade pip cffi ansible==$AnsibleV; \
#     apk del build-dependencies python-dev libffi-dev build-base; \
#     rm -rf /var/cache/apk/*

# switch to regular account
ARG GrpName=agroup
ARG GrpUID=1100
ARG UsrName=auser
ARG UsrUID=1000
RUN addgroup --gid ${GrpUID} --group ${GrpName};
#RUN  adduser ${UsrName} --group ${GrpName} ;
#RUN apk add openssh-client -y

#USER ${UsrName}
RUN  whoami;uname -a;
CMD printf "USAGE:\t docker run --rm lifeci/onbuild:ansible-debian$(cat ./BuildNo) ansible --help\n"
