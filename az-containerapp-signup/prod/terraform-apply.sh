#!/bin/bash
USER_ASSIGNED_MANAGED_IDENTITY_RESOURCE_GROUP="msk-prod-managed-identity"
USER_ASSIGN_MANAGED_IDENTITY="msk-prod-managed-identity"
STORAGE_RESOURCE_GROUP_PROD="msk-prod-storage-account"
PROD_STORAGE_ACCOUNT_NAME="mskprodstorage428"
CONTAINERAPP_ENVIRONMENT="msk-prod-signup"
CONTAINER_APP_NAME="msk-prod-signup"
WORKSPACE_NAME="msk-prod-signup"
RESOURCE_GROUP="msk-prod-signup"
IMAGE_NAME="msk-signup"
USERNAME="cloudwithdeb"
LOCATION="westeurope"
PORT=5123



az provider register --namespace Microsoft.App
az group create --name $RESOURCE_GROUP --location $LOCATION
az monitor log-analytics workspace create -g $RESOURCE_GROUP -n $WORKSPACE_NAME

WORKSPACE_ID=`az monitor log-analytics workspace show --query customerId -g $RESOURCE_GROUP -n $WORKSPACE_NAME -o tsv | tr -d '[:space:]'`
WORKSPACE_PRIMARY_KEY=`az monitor log-analytics workspace get-shared-keys --query primarySharedKey -g $RESOURCE_GROUP -n $WORKSPACE_NAME -o tsv | tr -d '[:space:]'`
az containerapp env create --name $CONTAINERAPP_ENVIRONMENT --logs-workspace-key $WORKSPACE_PRIMARY_KEY \
--resource-group $RESOURCE_GROUP --location $LOCATION --logs-workspace-id $WORKSPACE_ID

ManagedIdentityClientID=`az identity show --query clientId -n $USER_ASSIGN_MANAGED_IDENTITY -g $USER_ASSIGNED_MANAGED_IDENTITY_RESOURCE_GROUP -o tsv`

az containerapp create -n $CONTAINER_APP_NAME --resource-group $RESOURCE_GROUP --environment $CONTAINERAPP_ENVIRONMENT --image $USERNAME/$IMAGE_NAME-prod:latest  \
--target-port $PORT --ingress 'external' --query properties.configuration.ingress.fqdn  --min-replicas 0 --max-replicas 7 \
--env-vars DEV_URL="https://mskdevstorage428.table.core.windows.net" ORGANIZATION="mskOrganization" USERS_LOGIN="mskUsersLogin" PRODUCT_PROFILE="products-profile" \
PROD_URL="https://mskprodstorage428.table.core.windows.net" EMPLOYEES="mskEmployees" TAGS="mskTag" IMAGE_UPLOADS="msk-imageuploads" USER_PROFILE="users-profile" \
STAGE_URL="https://mskstagestorage428.table.core.windows.net" SUBSCRIPTION="mskSubscription" CATEGORY="mskCategory" PROD_MANAGED_IDENTITY_URL=$ManagedIdentityClientID \
WAREHOUSE="mskWarehouse" USERS_ROLES="mskUsersRoles" REGISTERED_USERS="mskRegisteredUsers" DEV_KEYVAULT_URL="https://msk-dev.vault.azure.net/" \
STAGE_KEYVAULT_URL="https://msk-stage.vault.azure.net/" PROD_KEYVAULT_URL="https://msk-prod.vault.azure.net/"


USER_ASSIGNED_MANAGED_IDENTITY_ID=`az identity show --query id -n $USER_ASSIGN_MANAGED_IDENTITY -g $USER_ASSIGNED_MANAGED_IDENTITY_RESOURCE_GROUP -o tsv`
az containerapp identity assign -n $CONTAINER_APP_NAME -g $RESOURCE_GROUP --user-assigned $USER_ASSIGNED_MANAGED_IDENTITY_ID

