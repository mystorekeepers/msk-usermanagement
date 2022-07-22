resource "azurerm_resource_group" "msk-stage-managed-identity-resource-group" {
  name     = var.msk-resource-group
  location = var.msk-location
  tags = {
    "name"             = var.msk-resource-group
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }

}

resource "azurerm_user_assigned_identity" "msk-stage-managed-identity" {
  resource_group_name = azurerm_resource_group.msk-stage-managed-identity-resource-group.name
  location            = azurerm_resource_group.msk-stage-managed-identity-resource-group.location
  name                = var.managed-identity-name
  tags = {
    "name"             = var.managed-identity-name
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }

}
