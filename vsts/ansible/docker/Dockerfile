ARG BasedOn=vstsansible
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG DockerV
ARG DockerComposeV

ADD ./docker/scripts ./scripts

RUN sh -c ./scripts/install-docker.sh $DockerV
RUN sh -c ./scripts/install-docker-compose.sh $DockerComposeV
RUN apt update; apt-get install -y --no-install-recommends \
    python-pip python-setuptools python-wheel jq

RUN docker-compose --version; \
    docker --version;
