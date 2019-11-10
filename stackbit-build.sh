#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://5c95fc57.ngrok.io/project/5dc15fdd56921b66b2c169d9/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://5c95fc57.ngrok.io/pull/5dc15fdd56921b66b2c169d9 
fi
curl -s -X POST https://5c95fc57.ngrok.io/project/5dc15fdd56921b66b2c169d9/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://5c95fc57.ngrok.io/project/5dc15fdd56921b66b2c169d9/webhook/build/publish > /dev/null
