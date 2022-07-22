#!/bin/bash

USER_ASSIGNED_MANAGED_IDENTITY_RESOURCE_GROUP="msk-stage-managed-identity"
USER_ASSIGN_MANAGED_IDENTITY="msk-stage-managed-identity"
CONTAINER_APP_RESOURCE_GROUP="msk-stage-signup"
CONTAINERAPP_ENVIRONMENT="msk-stage-signup"
CONTAINER_APP_NAME="msk-stage-signup"
WORKSPACE_NAME="msk-stage-signup"
IMAGE_NAME="msk-signup"
USERNAME="cloudwithdeb"
LOCATION="westeurope"
PORT=5123

az provider register --namespace Microsoft.App
az group create --name $CONTAINER_APP_RESOURCE_GROUP --location $LOCATION
az monitor log-analytics workspace create -g $CONTAINER_APP_RESOURCE_GROUP -n $WORKSPACE_NAME

WORKSPACE_ID=`az monitor log-analytics workspace show --query customerId -g $CONTAINER_APP_RESOURCE_GROUP -n $WORKSPACE_NAME -o tsv | tr -d '[:space:]'`
WORKSPACE_PRIMARY_KEY=`az monitor log-analytics workspace get-shared-keys --query primarySharedKey -g $CONTAINER_APP_RESOURCE_GROUP -n $WORKSPACE_NAME -o tsv | tr -d '[:space:]'`

az containerapp env create --name $CONTAINERAPP_ENVIRONMENT --logs-workspace-key $WORKSPACE_PRIMARY_KEY \
--resource-group $CONTAINER_APP_RESOURCE_GROUP --location $LOCATION --logs-workspace-id $WORKSPACE_ID

ManagedIdentityClientID=`az identity show --query clientId -n $USER_ASSIGN_MANAGED_IDENTITY -g $USER_ASSIGNED_MANAGED_IDENTITY_RESOURCE_GROUP -o tsv`

az containerapp create -n $CONTAINER_APP_NAME --resource-group $CONTAINER_APP_RESOURCE_GROUP --environment $CONTAINERAPP_ENVIRONMENT --image $USERNAME/$IMAGE_NAME-stage:latest  \
--target-port $PORT --ingress 'external' --target-port $PORT --query properties.configuration.ingress.fqdn  --min-replicas 0 --max-replicas 3 \
--env-vars DEV_URL="https://mskdevstorage428.table.core.windows.net" ORGANIZATION="mskOrganization" USERS_LOGIN="mskUsersLogin" PROD_KEYVAULT_URL="https://msk-prod.vault.azure.net/" \
PROD_URL="https://mskprodstorage428.table.core.windows.net" EMPLOYEES="mskEmployees" TAGS="mskTag" IMAGE_UPLOADS="msk-imageuploads" PRODUCT_PROFILE="products-profile" \
STAGE_URL="https://mskstagestorage428.table.core.windows.net" SUBSCRIPTION="mskSubscription" CATEGORY="mskCategory" USER_PROFILE="users-profile" DEV_KEYVAULT_URL="https://msk-dev.vault.azure.net/" \
WAREHOUSE="mskWarehouse" USERS_ROLES="mskUsersRoles" REGISTERED_USERS="mskRegisteredUsers"  STAGE_KEYVAULT_URL="https://msk-stage.vault.azure.net/" DEV_STAGE_MANAGED_IDENTITY_URL=$ManagedIdentityClientID 

USER_ASSIGNED_MANAGED_IDENTITY_ID=`az identity show --query id -n $USER_ASSIGN_MANAGED_IDENTITY -g $USER_ASSIGNED_MANAGED_IDENTITY_RESOURCE_GROUP -o tsv`
az containerapp identity assign -n $CONTAINER_APP_NAME -g $CONTAINER_APP_RESOURCE_GROUP --user-assigned $USER_ASSIGNED_MANAGED_IDENTITY_ID
