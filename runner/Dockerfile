ARG BasedOn=base
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
MAINTAINER rj-lifeci

WORKDIR /app


ARG RunnerVersion
# Download
RUN mkdir actions-runner && cd actions-runner && \
        curl -O -L https://github.com/actions/runner/releases/download/v${RunnerVersion}/actions-runner-linux-x64-${RunnerVersion}.tar.gz && \
        tar xzf ./actions-runner-linux-x64-*.tar.gz

RUN chmod +rx ./actions-runner/* && ls -la ./actions-runner

# deps
RUN apt install apt-utils -y && \
        ./actions-runner/bin/installdependencies.sh

COPY ./*.sh ./
RUN chmod +x start.sh; ls -la

ARG UserName=runner-user
RUN adduser --no-create-home \
        --disabled-password \
        --uid 1000 \
        $UserName && \
        chown -R $UserName ./actions-runner

USER $UserName

STOPSIGNAL SIGTERM
#  SIGTERM -> exit 143' TERM | SIGINT -> exit 130' INT
ENTRYPOINT ./start.sh
