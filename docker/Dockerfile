ARG BuildNo
ARG BasedOn=base
FROM lifeci/onbuild:${BasedOn}${BuildNo}
MAINTAINER rj-lifeci
ARG DockerV
ARG DockerComposeV
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo

ADD ./scripts ./scripts
RUN echo "DockerV: $DockerV"; \
    ./scripts/install-docker.sh $DockerV cli-only

RUN sh -c ./scripts/install-docker-compose.sh $DockerComposeV
RUN apt update; apt-get install -y --no-install-recommends \
    python-pip python-setuptools python-wheel jq

RUN docker-compose --version; \
    docker --version;

CMD printf "USAGE:\t docker run --rm lifeci/onbuild:docker$(cat ./BuildNo) docker --help\n\
USAGE:\t docker run --rm lifeci/onbuild:docker$(cat ./BuildNo) docker-compose --help\n"
