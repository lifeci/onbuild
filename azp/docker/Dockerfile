ARG BasedOn=azp
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG DockerV
ARG DockerComposeV

ADD ./docker/scripts ./scripts
RUN echo "DockerV: $DockerV"; \
    ./scripts/install-docker.sh $DockerV cli-only
RUN sh -c ./scripts/install-docker-compose.sh $DockerComposeV
RUN apt update; apt-get install -y --no-install-recommends \
    python-pip python-setuptools python-wheel jq

RUN docker-compose --version; \
    docker --version;
