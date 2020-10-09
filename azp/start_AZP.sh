#!/bin/bash
mode=$1
set -e

export VSO_AGENT_IGNORE=_,MAIL,OLDPWD,PATH,PWD,AZP_AGENT,AZP_ACCOUNT,AZP_TOKEN_FILE,AZP_TOKEN,AZP_POOL,AZP_WORK,VSO_AGENT_IGNORE,AZP_AGENT,AZP_ACCOUNT,AZP_TOKEN,AZP_DEPLOYMENT_PROJECT,AZP_DEPLOYMENT_GRP_NAME,AZP_DEPLOYMENT_TAGS
if [ -n "$AZP_AGENT_IGNORE" ]; then
  export VSO_AGENT_IGNORE=$VSO_AGENT_IGNORE,AZP_AGENT_IGNORE,$AZP_AGENT_IGNORE
fi

if [ -e /azp/agent -a ! -e /azp/.configure ]; then
  trap 'kill -SIGINT $!; exit 130' INT
  trap 'kill -SIGTERM $!; exit 143' TERM
  /azp/agent/bin/Agent.Listener run &
  wait $!
  exit $?
fi

if [ -z "$AZP_ACCOUNT" ]; then
  echo 1>&2 error: missing AZP_ACCOUNT environment variable
  exit 1
fi

if [ -z "$AZP_TOKEN_FILE" ]; then
  if [ -z "$AZP_TOKEN" ]; then
    echo 1>&2 error: missing AZP_TOKEN environment variable
    exit 1
  fi
  AZP_TOKEN_FILE=/azp/.token
  echo -n $AZP_TOKEN >"$AZP_TOKEN_FILE"
fi
unset AZP_TOKEN

if [ -n "$AZP_AGENT" ]; then
  export AZP_AGENT="$(eval echo $AZP_AGENT)"
fi

if [ -n "$AZP_WORK" ]; then
  export AZP_WORK="$(eval echo $AZP_WORK)"
  mkdir -p "$AZP_WORK"
fi

touch /azp/.configure
rm -rf /azp/agent
mkdir /azp/agent
cd /azp/agent

web-server() {
  while true; do
    printf 'HTTP/1.1 302 Found\r\nLocation: https://'$AZP_ACCOUNT'.visualstudio.com/_admin/_AgentPool\r\n\r\n' | nc -l -p 80 -q 0 >/dev/null
  done
}

cleanup() {
  if [ -e config.sh ]; then
    ./bin/Agent.Listener remove --unattended \
      --auth PAT \
      --token $(cat "$AZP_TOKEN_FILE")
  fi
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

echo Determining matching AZP agent...
AZP_AGENT_RESPONSE=$(curl -LsS \
  -u user:$(cat "$AZP_TOKEN_FILE") \
  -H 'Accept:application/json;api-version=3.0-preview' \
  "https://$AZP_ACCOUNT.visualstudio.com/_apis/distributedtask/packages/agent?platform=linux-x64")

if echo "$AZP_AGENT_RESPONSE" | jq . >/dev/null 2>&1; then
  AZP_AGENT_URL=$(echo "$AZP_AGENT_RESPONSE" |
    jq -r '.value | map([.version.major,.version.minor,.version.patch,.downloadUrl]) | sort | .[length-1] | .[3]')
fi

if [ -z "$AZP_AGENT_URL" -o "$AZP_AGENT_URL" == "null" ]; then
  echo 1>&2 error: could not determine a matching AZP agent - check that account \'$AZP_ACCOUNT\' is correct and the token is valid for that account
  exit 1
fi

echo Downloading and installing AZP agent...
curl -LsS $AZP_AGENT_URL | tar -xz --no-same-owner &
wait $!

source ./env.sh
if [ "$mode" == "deployment" ]; then
  echo "run as mode: $mode | AZP_DEPLOYMENT_GRP_NAME: $AZP_DEPLOYMENT_GRP_NAME | AZP_DEPLOYMENT_PROJECT: $AZP_DEPLOYMENT_PROJECT | AZP_DEPLOYMENT_TAGS: $AZP_DEPLOYMENT_TAGS"
  ./bin/Agent.Listener configure --unattended --deploymentGroup \
    --agent "${AZP_AGENT:-$(hostname)}" \
    --url "https://dev.azure.com/$AZP_ACCOUNT" \
    --auth pat \
    --token $(cat "$AZP_TOKEN_FILE") \
    --deploymentGroupName "${AZP_DEPLOYMENT_GRP_NAME}" \
    --projectname "${AZP_DEPLOYMENT_PROJECT}" \
    --addDeploymentGroupTags --DeploymentGroupTags "${AZP_DEPLOYMENT_TAGS}" \
    --DeploymentPoolName "${AZP_DEPLOYMENT_POOL}" \
    --work "${AZP_WORK:-_work}" \
    --replace &
  wait $!
  # AGENT_ALLOW_RUNASROOT=true ./config.sh --help
else
  ./bin/Agent.Listener configure --unattended \
    --agent "${AZP_AGENT:-$(hostname)}" \
    --url "https://dev.azure.com/$AZP_ACCOUNT" \
    --auth PAT \
    --token $(cat "$AZP_TOKEN_FILE") \
    --pool "${AZP_POOL:-Default}" \
    --work "${AZP_WORK:-_work}" \
    --replace &
  wait $!
fi

web-server &
./bin/Agent.Listener run &
wait $!
