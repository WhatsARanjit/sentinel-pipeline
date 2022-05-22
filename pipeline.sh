#!/bin/bash

violations=()
exitcode=0

# Check to make sure every policy has a pass/fail test
for i in $(ls -1 *.sentinel); do
  policy=$(basename -s .sentinel $i)

  if [[ ! -f "test/${policy}/pass.hcl" && ! -f "test/${policy}/fail.hcl" ]]; then
    violations+=("$policy")
    exitcode=1
  fi
done

# Echo any violations
for i in "${violations[@]}"; do
  >&2 echo "${i}.sentinel does not have any pass/fail tests"
done

# Stop here if any violations
if [[ $exitcode -ne 0 ]]; then
  exit $exitcode
fi

# Run tests if all tests exist
curl -o sentinel.zip -L "https://releases.hashicorp.com/sentinel/${SENTINEL_VERSION}/sentinel_${SENTINEL_VERSION}_linux_amd64.zip"
unzip sentinel.zip
chmod +x sentinel

./sentinel test -verbose
