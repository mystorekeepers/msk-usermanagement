
data "azurerm_application_insights" "msk-stage-application-insight-data" {
  name                = var.application-insight-resource-group-and-name["application-insight-name"]
  resource_group_name = var.application-insight-resource-group-and-name["application-insight-resource-group-name"]
}

data "azurerm_storage_account" "msk-stage-storage-account" {
  name                = var.storage-account-container-and-resource-group["storage-account-name"]
  resource_group_name = var.storage-account-container-and-resource-group["storage-account-resource-group"]
}

data "azurerm_user_assigned_identity" "msk-stage-managed-identity" {
  name                = var.managed-identity-resource-group-and-name["managed-identity-name"]
  resource_group_name = var.managed-identity-resource-group-and-name["managed-identity-resource-group"]
}

resource "azurerm_resource_group" "az-msk-stage-add-employee-rg" {
  name     = var.msk-function-resource-group
  location = var.msk-default-location
  tags = {
    "name"             = var.msk-function-resource-group
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_storage_account" "az-msk-addemployee-storage-account" {
  name                     = var.msk-function-storage-account
  resource_group_name      = azurerm_resource_group.az-msk-stage-add-employee-rg.name
  location                 = azurerm_resource_group.az-msk-stage-add-employee-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    "name"             = var.msk-function-storage-account
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_app_service_plan" "az-msk-function-service-plan" {
  name                = var.msk-service-plan-name
  location            = azurerm_resource_group.az-msk-stage-add-employee-rg.location
  resource_group_name = azurerm_resource_group.az-msk-stage-add-employee-rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  lifecycle {
    ignore_changes = [
      kind
    ]
  }

  tags = {
    "name"             = var.msk-service-plan-name
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_function_app" "az-msk-function-app" {
  name                       = var.msk-function-app-name
  location                   = azurerm_resource_group.az-msk-stage-add-employee-rg.location
  resource_group_name        = azurerm_resource_group.az-msk-stage-add-employee-rg.name
  app_service_plan_id        = azurerm_app_service_plan.az-msk-function-service-plan.id
  storage_account_name       = azurerm_storage_account.az-msk-addemployee-storage-account.name
  storage_account_access_key = azurerm_storage_account.az-msk-addemployee-storage-account.primary_access_key
  os_type                    = "linux"
  version                    = "~4"

  app_settings = {

    FUNCTIONS_WORKER_RUNTIME       = "dotnet"
    APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.msk-stage-application-insight-data.instrumentation_key
    DEV_STAGE_MANAGED_IDENTITY_URL = data.azurerm_user_assigned_identity.msk-stage-managed-identity.client_id

    DEV_STORAGE_ACCOUNT            = "mskdevstorage428"
    STAGE_STORAGE_ACCOUNT          = "mskstagestorage428"
    PROD_STORAGE_ACCOUNT           = "mskprodstorage428"

    DEV_URL                        = "https://mskdevstorage428.table.core.windows.net"
    PROD_URL                       = "https://mskprodstorage428.table.core.windows.net"
    STAGE_URL                      = "https://mskstagestorage428.table.core.windows.net"
    
    EMPLOYEES = "mskEmployees",
    USERS_ROLES = "mskUsersRoles",
    USERS_LOGIN = "mskUsersLogin"

  }

  site_config {
    dotnet_framework_version = "v6.0"
    always_on                = false
    cors {
      allowed_origins = ["*"]
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.msk-stage-managed-identity.id]
  }

  tags = {
    "name"             = var.msk-function-app-name
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}
