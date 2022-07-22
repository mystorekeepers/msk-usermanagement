

resource "azurerm_resource_group" "msk-application-insight-resource-group" {
  name     = var.msk-application-insight-resource-group
  location = var.msk-default-location
  tags = {
    "name"             = var.msk-application-insight-resource-group
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_application_insights" "az-msk-function-apps-application-insight" {
  name                = var.msk-application-insight-name
  location            = azurerm_resource_group.msk-application-insight-resource-group.location
  resource_group_name = azurerm_resource_group.msk-application-insight-resource-group.name
  application_type    = var.msk-application-insight-type
  tags = {
    "name"             = var.msk-application-insight-name
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}
