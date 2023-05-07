#!/bin/bash

if ! test -n "$WORKSPACE"; then
  echo "Remember to set the WORKSPACE environment variable"
  exit 1
else
  echo "Processing $WORKSPACE"
  terraform workspace select $WORKSPACE
  terraform plan -var-file="$WORKSPACE.tfvars"
fi

printf "\n\nIf you are satisfied, run the following command:\n\nterraform apply -var-file=\"$WORKSPACE.tfvars\"\n\n"
