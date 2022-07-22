
resource "azurerm_resource_group" "msk-dev-cosmosdb-resource-group" {
  name     = var.cosmosdb-sqlapi-configurations["resource_group_name"]
  location = var.msk-default-location
  tags = {
    "name"             = var.cosmosdb-sqlapi-configurations["resource_group_name"]
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "random_integer" "generate-random-number-and-append-to-cosmosdb-name" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "msk-dev-cosmosdb-database-account" {
  name                = "${var.cosmosdb-sqlapi-configurations["cosmosdb_account_name"]}-${random_integer.generate-random-number-and-append-to-cosmosdb-name.result}"
  location            = azurerm_resource_group.msk-dev-cosmosdb-resource-group.location
  resource_group_name = azurerm_resource_group.msk-dev-cosmosdb-resource-group.name
  offer_type          = var.cosmosdb-sqlapi-configurations["offer_type"]
  kind                = var.cosmosdb-sqlapi-configurations["kind"]

  enable_automatic_failover = true

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = azurerm_resource_group.msk-dev-cosmosdb-resource-group.location
    failover_priority = 0
  }

  tags = {
    "name"             = "${var.cosmosdb-sqlapi-configurations["cosmosdb_account_name"]}-${random_integer.generate-random-number-and-append-to-cosmosdb-name.result}"
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

