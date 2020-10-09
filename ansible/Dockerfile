ARG BasedOn=base
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
MAINTAINER rj-lifeci
ARG AnsibleV=2.6.1
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo

RUN pip install --upgrade pip;

RUN apt update && apt-cache madison ansible && apt install ansible=$AnsibleV -y
#RUN pip install ansible=$AnsibleV;

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
