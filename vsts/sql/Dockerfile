ARG BuildNo
FROM lifeci/onbuild:vsts${BuildNo}

ADD ./install-sqlpackage.sh ./scripts/
RUN sh -c ./scripts/install-sqlpackage.sh

ADD ./install-sqlcmd.sh ./scripts/
RUN sh -c ./scripts/install-sqlcmd.sh
