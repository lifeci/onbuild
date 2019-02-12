ARG BasedOn=vsts
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}

ADD ./install-sqlpackage.sh ./scripts/
RUN sh -c ./scripts/install-sqlpackage.sh
ENV PATH=$PATH:/opt/sqlpackage/

ADD ./install-sqlcmd.sh ./scripts/
RUN sh -c ./scripts/install-sqlcmd.sh
ENV PATH=$PATH:/opt/mssql-tools/bin/
