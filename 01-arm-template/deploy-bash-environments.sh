#!/bin/bash

# simple example of how to integrate bash scripting with azure cli

az group create --name test --location eastus2

for env in dev stg prod
do
    az group deployment create --resource-group test --parameters storagePrefix=alo kind=StorageV2 accessTier=hot supportsHttpsTrafficOnly=true --template-file template.json
done

