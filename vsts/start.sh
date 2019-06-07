#!/bin/bash
set -e

export VSO_AGENT_IGNORE=_,MAIL,OLDPWD,PATH,PWD,VSTS_AGENT,VSTS_ACCOUNT,VSTS_TOKEN_FILE,VSTS_TOKEN,VSTS_POOL,VSTS_WORK,VSO_AGENT_IGNORE

if [ -z $VSTS_AGENT_VERSION ]; then
  VSTS_AGENT_VERSION=2.150.0; #2.140.0;
fi;

echo "VSTS_AGENT_VERSION: ${VSTS_AGENT_VERSION}"
VSTS_AGENT_URL="https://vstsagentpackage.azureedge.net/agent/${VSTS_AGENT_VERSION}/vsts-agent-linux-x64-${VSTS_AGENT_VERSION}.tar.gz"

echo "$VSTS_AGENT_URL"
if [ -n "$VSTS_ACCOUNT" ]; then
  echo "START VSTS: VSTS_ACCOUNT is $VSTS_ACCOUNT"

  RunAs=VSTS

elif [ -n "$TFS_HOST" ] || [ -n "$TFS_URL" ]; then
  echo "START TFS: TFS_HOST is $TFS_HOST; TFS_URL is $TFS_URL"
  set -x
  curl -fSL $VSTS_AGENT_URL -o agent.tgz; mkdir -p agent; cd agent;
  tar -xz --no-same-owner -f ../agent.tgz; cd ..; rm agent.tgz

  RunAs=TFS

else
  echo "ERORR: Not found any of VSTS_ACCOUNT, TFS_URL, TFS_HOST"
  exit -1
fi

#SIGTERM is 15 | SIGINT is 2 | SIGKILL is 9
#trap "echo 'Got SIGINT'; kill -SIGINT $PID" INT
#trap "echo 'Got SIGTERM'; kill -SIGTERM $PID" TERM
if [ -n $VSTS_DEPLOYMENT_GRP_NAME ]; then
  ./start_$RunAs.sh deployment
else
  ./start_$RunAs.sh
fi;
#export PID=$!
#echo "$PID" > /vsts/PID
#echo "Agent PID is $( cat /vsts/PID )"
# INFO: http://veithen.io/2014/11/16/sigterm-propagation.html
