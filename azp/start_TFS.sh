#!/bin/bash
set -e

if [ -z "$TFS_HOST" -a -z "$TFS_URL" ]; then
  echo 1>&2 error: missing TFS_HOST environment variable
  exit 1
fi

if [ -z "$TFS_URL" ]; then
  export TFS_URL=https://$TFS_HOST/tfs
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

cd /azp/agent

web-server() {
  while true; do
    printf 'HTTP/1.1 302 Found\r\nLocation: $TFS_URL/_admin/_AgentPool\r\n\r\n' | nc -l -p 80 -q 0 >/dev/null
  done
}

cleanup() {
  ./bin/Agent.Listener remove --unattended \
    --auth PAT \
    --token $(cat "$AZP_TOKEN_FILE")
}

if [ -e .agent ]; then
  echo "Removing existing AZP agent configuration..."
  cleanup
fi

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

export VSO_AGENT_IGNORE=_,MAIL,OLDPWD,PATH,PWD,AZP_AGENT,TFS_HOST,TFS_URL,AZP_TOKEN_FILE,AZP_TOKEN,AZP_POOL,AZP_WORK,VSO_AGENT_IGNORE
if [ -n "$AZP_AGENT_IGNORE" ]; then
  export VSO_AGENT_IGNORE=$VSO_AGENT_IGNORE,AZP_AGENT_IGNORE,$AZP_AGENT_IGNORE
fi

source ./env.sh

./bin/Agent.Listener configure --unattended \
  --agent "${AZP_AGENT:-$(hostname)}" \
  --url "$TFS_URL" \
  --auth PAT \
  --token $(cat "$AZP_TOKEN_FILE") \
  --pool "${AZP_POOL:-Default}" \
  --work "${AZP_WORK:-_work}" \
  --replace &
wait $!

web-server &
./bin/Agent.Listener run &
wait $!
