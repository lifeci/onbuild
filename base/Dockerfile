ARG DebianV
FROM debian:${DebianV}

WORKDIR /opt/base

MAINTAINER rj-lifeci
ARG VirtEnvV
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo

RUN apt update; apt-get install -y --no-install-recommends \
    python-pip python-setuptools python-wheel jq openssh-client curl ssh-askpass

RUN pip install virtualenv==$VirtEnvV
    # package~=15.* | "package>=0.2,<0.3" |
RUN apt-get autoremove -y
RUN pip --version;  virtualenv --version;
CMD printf "USAGE:\t docker run --rm lifeci/onbuild:docker$(cat ./BuildNo) bash -c 'uname -a'\n"
