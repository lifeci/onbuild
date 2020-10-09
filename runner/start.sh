#!/bin/bash
set -e

cd ./actions-runner
ls -la
echo "GH_URL: $GH_URL | GH_TOKEN: $GH_TOKEN"

./config.sh --url $GH_URL --token $GH_TOKEN &&
  ./run.sh

# term: /app/actions-runner/config.sh remove --token $GH_TOKEN
