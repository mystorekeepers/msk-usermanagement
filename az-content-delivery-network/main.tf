
resource "azurerm_resource_group" "msk-cdn-resource-group" {
  name     = var.msk-dns-resource-group
  location = var.msk-default-location
  tags = {
    "name"             = var.msk-dns-resource-group
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_cdn_profile" "msk-cdn" {
  name                = var.cdn-name
  location            = azurerm_resource_group.msk-cdn-resource-group.location
  resource_group_name = azurerm_resource_group.msk-cdn-resource-group.name
  sku                 = var.cdn-sku

  tags = {
    "name"             = var.cdn-name
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

