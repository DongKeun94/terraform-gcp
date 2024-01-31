#!/bin/bash

MAX_RETRIES=3
RETRY_INTERVAL=5

retry=0

while [ $retry -lt $MAX_RETRIES ]; do
  terraform apply -auto-approve
  if [ $? -eq 0 ]; then
    echo "Terraform apply succeeded"
    break
  else
    echo "Terraform apply failed. Retrying in $RETRY_INTERVAL seconds..."
    sleep $RETRY_INTERVAL
    ((retry++))
  fi
done

if [ $retry -eq $MAX_RETRIES ]; then
  echo "Terraform apply failed after $MAX_RETRIES retries. Exiting..."
  exit 1
fi
