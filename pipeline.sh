#!/bin/bash

curl -o sentinel.zip -L "https://releases.hashicorp.com/sentinel/${SENTINEL_VERSION}/sentinel_${SENTINEL_VERSION}_linux_amd64.zip"
unzip sentinel.zip
chmod +x sentinel

./sentinel test -verbose
