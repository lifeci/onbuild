ARG DebianV
FROM lifeci/onbuild:base${BuildNo}
MAINTAINER rj-lifeci
ARG DockerV
ARG DockerComposeV

ADD ./scripts ./scripts
RUN sh -c ./scripts/install-docker.sh $DockerV
RUN sh -c ./scripts/install-docker-compose.sh $DockerComposeV
RUN apt update; apt-get install -y --no-install-recommends \
    python-pip python-setuptools python-wheel jq

RUN apt-get autoremove -y
RUN docker-compose --version; \
    docker --version;
CMD ["bash"]
