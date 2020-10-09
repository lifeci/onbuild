#!/bin/bash
set -e

export VSO_AGENT_IGNORE=_,MAIL,OLDPWD,PATH,PWD,AZP_AGENT,AZP_ACCOUNT,AZP_TOKEN_FILE,AZP_TOKEN,AZP_POOL,AZP_WORK,VSO_AGENT_IGNORE

if [ -z $AZP_AGENT_VERSION ]; then
  AZP_AGENT_VERSION=2.150.0 #2.140.0;
fi

echo "AZP_AGENT_VERSION: ${AZP_AGENT_VERSION}"
AZP_AGENT_URL="https://azpagentpackage.azureedge.net/agent/${AZP_AGENT_VERSION}/azp-agent-linux-x64-${AZP_AGENT_VERSION}.tar.gz"

echo "$AZP_AGENT_URL"
if [ -n "$AZP_ACCOUNT" ]; then
  echo "START AZP: AZP_ACCOUNT is $AZP_ACCOUNT"

  RunAs=AZP

elif [ -n "$TFS_HOST" ] || [ -n "$TFS_URL" ]; then
  echo "START TFS: TFS_HOST is $TFS_HOST; TFS_URL is $TFS_URL"
  set -x
  curl -fSL $AZP_AGENT_URL -o agent.tgz
  mkdir -p agent
  cd agent
  tar -xz --no-same-owner -f ../agent.tgz
  cd ..
  rm agent.tgz

  RunAs=TFS

else
  echo "ERORR: Not found any of AZP_ACCOUNT, TFS_URL, TFS_HOST"
  exit -1
fi

#SIGTERM is 15 | SIGINT is 2 | SIGKILL is 9
#trap "echo 'Got SIGINT'; kill -SIGINT $PID" INT
#trap "echo 'Got SIGTERM'; kill -SIGTERM $PID" TERM
if [ -n "$AZP_DEPLOYMENT_GRP_NAME" ]; then
  ./start_$RunAs.sh deployment
else
  ./start_$RunAs.sh
fi
#export PID=$!
#echo "$PID" > /azp/PID
#echo "Agent PID is $( cat /azp/PID )"
# INFO: http://veithen.io/2014/11/16/sigterm-propagation.html
