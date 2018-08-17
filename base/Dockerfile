ARG DebianV
FROM debian:${DebianV}
MAINTAINER rj-lifeci
ARG VirtEnvV

RUN apt update; apt-get install -y --no-install-recommends \
    python-pip python-setuptools python-wheel jq

RUN pip install virtualenv==$VirtEnvV
    # package~=15.* | "package>=0.2,<0.3" |
RUN apt-get autoremove -y

RUN pip --version;  virtualenv --version;
CMD ["bash"]
