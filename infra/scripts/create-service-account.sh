#!/usr/bin/env bash

PRIVATE_KEY_PATH="/tmp/google-key.json"

gcloud iam service-accounts create connectionhub-serviceaccount --description="service account for terraform deployment in connection hub project" --display-name="connection_hub_service_account"

EMAIL=$( gcloud iam service-accounts list | grep connectionhub |  tr -s ' ' | cut -d' ' -f2 )

gcloud iam service-accounts keys create $PRIVATE_KEY_PATH --iam-account $EMAIL

