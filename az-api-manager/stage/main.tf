
resource "azurerm_resource_group" "msk-stage-apimanagement-resource-group" {
  name     = var.msk-apigateway-resource-group
  location = var.msk-default-location
   tags = {
    "name"             = var.msk-apigateway-resource-group
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "purpose"          = var.tags["purpose"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_log_analytics_workspace" "msk-stage-apigateway-app-insight-log-workspace" {
  name                = var.msk-apigateway-log-analytics["ANALYTICS_WORKSPACE_NAME"]
  location            = azurerm_resource_group.msk-stage-apimanagement-resource-group.location
  resource_group_name = azurerm_resource_group.msk-stage-apimanagement-resource-group.name
  sku                 = var.msk-apigateway-log-analytics["ANALYTICS_SKU"]
  retention_in_days   = var.msk-apigateway-log-analytics["RETENTION_DAYS"]
  tags = {
    "name"             = var.msk-apigateway-log-analytics["ANALYTICS_WORKSPACE_NAME"]
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "purpose"          = var.tags["purpose"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_application_insights" "msk-stage-apigateway-insight" {
  name                = var.msk-apigateway-application-insight["NAME"]
  location            = azurerm_resource_group.msk-stage-apimanagement-resource-group.location
  resource_group_name = azurerm_resource_group.msk-stage-apimanagement-resource-group.name
  workspace_id        = azurerm_log_analytics_workspace.msk-stage-apigateway-app-insight-log-workspace.id
  application_type    = var.msk-apigateway-application-insight["APPLICATION_TYPE"]
   tags = {
    "name"             = var.msk-apigateway-application-insight["NAME"]
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "purpose"          = var.tags["purpose"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_api_management" "msk-stage-apigateway" {
  name                = var.msk-apigateway-management["NAME"]
  location            = azurerm_resource_group.msk-stage-apimanagement-resource-group.location
  resource_group_name = azurerm_resource_group.msk-stage-apimanagement-resource-group.name
  publisher_name      = var.msk-apigateway-management["PUBLISHER_NAME"]
  publisher_email     = var.msk-apigateway-management["PUBLISHER_EMAIL"]
  sku_name            = var.msk-apigateway-management["SKU_NAME"]

  tags = {
    "name"             = var.msk-apigateway-management["NAME"]
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "purpose"          = var.tags["purpose"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_api_management_logger" "msk-stage-api-logger" {
  name                = var.msk-apigateway-management["LOGER_NAME"]
  api_management_name = azurerm_api_management.msk-stage-apigateway.name
  resource_group_name = azurerm_resource_group.msk-stage-apimanagement-resource-group.name

  application_insights {
    instrumentation_key = azurerm_application_insights.msk-stage-apigateway-insight.instrumentation_key
  }

}
