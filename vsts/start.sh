#!/bin/bash
set -e

export VSO_AGENT_IGNORE=_,MAIL,OLDPWD,PATH,PWD,VSTS_AGENT,VSTS_ACCOUNT,VSTS_TOKEN_FILE,VSTS_TOKEN,VSTS_POOL,VSTS_WORK,VSO_AGENT_IGNORE

VSTS_AGENT_VERSION='2.140.0'
VSTS_AGENT_URL="https://vstsagentpackage.azureedge.net/agent/${VSTS_AGENT_VERSION}/vsts-agent-linux-x64-${VSTS_AGENT_VERSION}.tar.gz"
echo "$VSTS_AGENT_URL"
if [ -n "$VSTS_ACCOUNT" ]; then
  echo "START VSTS: VSTS_ACCOUNT is $VSTS_ACCOUNT"
  ./start_VSTS.sh
elif [ -n "$TFS_HOST" ] || [ -n "$TFS_URL" ]; then
  echo "START TFS: TFS_HOST is $TFS_HOST; TFS_URL is $TFS_URL"
  set -x
  curl -fSL $VSTS_AGENT_URL -o agent.tgz; mkdir agent; cd agent;
  tar -xz --no-same-owner -f ../agent.tgz; cd ..; rm agent.tgz
  ./start_TFS.sh
else
  echo "ERORR: Not found any of VSTS_ACCOUNT, TFS_URL, TFS_HOST"
  exit -1
fi
