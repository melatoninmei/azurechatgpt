#!/bin/bash

# https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/create-resource?pivots=cli

. ./env.sh

az cognitiveservices account create --name $MY_OPEN_AI_RESOURCE_NAME --resource-group $MY_OPEN_AI_RESOURCE_GROUP --location australiaeast --kind OpenAI --sku s0 --subscription $SUBSCRIPTION_ID

az cognitiveservices account show --name $MY_OPEN_AI_RESOURCE_NAME --resource-group  $MY_OPEN_AI_RESOURCE_GROUP | jq -r .properties.endpoint

az cognitiveservices account keys list --name $MY_OPEN_AI_RESOURCE_NAME --resource-group  $MY_OPEN_AI_RESOURCE_GROUP | jq -r .key1

az cognitiveservices account deployment create --name $MY_OPEN_AI_RESOURCE_NAME --resource-group  $MY_OPEN_AI_RESOURCE_GROUP --deployment-name MyModel --model-name text-embedding-ada-002 --model-version "1" --model-format OpenAI --sku-capacity "1" --sku-name "Standard"

az ad sp create-for-rbac --name OpenAICredential --role contributor --scopes /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$MY_OPEN_AI_RESOURCE_GROUP --sdk-auth --output json