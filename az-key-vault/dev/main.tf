
data "azurerm_cosmosdb_account" "msk-dev-cosmosdb-database-account" {
  name                = var.msk-dev-cosmosdb-configurations["cosmosdb-name"]
  resource_group_name = var.msk-dev-cosmosdb-configurations["resource_group_name"]
}

data "azurerm_client_config" "current" {}

data "azurerm_user_assigned_identity" "msk-stage-user-managed-identity" {
  name                = var.msk-stage-managed-identity["managed-identity-name"]
  resource_group_name = var.msk-stage-managed-identity["managed-identity-resource-group"]
}

resource "azurerm_resource_group" "mystorekeeper-keyvault-rg" {
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

resource "azurerm_key_vault" "mystorekeeper-keyvault" {
  name                        = var.msk-key-vault-config["NAME"]
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  location                    = azurerm_resource_group.mystorekeeper-keyvault-rg.location
  resource_group_name         = azurerm_resource_group.mystorekeeper-keyvault-rg.name
  enabled_for_disk_encryption = var.msk-key-vault-config["ENABLE_DISK_ENCRYPTION"]
  soft_delete_retention_days  = var.msk-key-vault-config["SOFT_DELETE_RETENTION_DAYS"]
  purge_protection_enabled    = var.msk-key-vault-config["PURGE_PROTECTION_ENABLE"]
  sku_name                    = var.msk-key-vault-config["SKU_NAME"]
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "Delete",
      "List",
      "Update"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete"
    ]

  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_user_assigned_identity.msk-stage-user-managed-identity.principal_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List"
    ]

  }

  tags = {
    "name"             = var.msk-key-vault-config["NAME"]
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
} 

locals {
  cosmosdb_primary_connection_string = "AccountEndpoint=${data.azurerm_cosmosdb_account.msk-dev-cosmosdb-database-account.endpoint};AccountKey=${data.azurerm_cosmosdb_account.msk-dev-cosmosdb-database-account.primary_key};"
  cosmosdb_secondary_connection_string = "AccountEndpoint=${data.azurerm_cosmosdb_account.msk-dev-cosmosdb-database-account.endpoint};AccountKey=${data.azurerm_cosmosdb_account.msk-dev-cosmosdb-database-account.secondary_key};"
}

resource "azurerm_key_vault_secret" "msk-dev-cosmosdb-primary-connection" {
  name         = var.cosmosdb-connection-sttrings-key["primary"]
  value        = local.cosmosdb_primary_connection_string
  key_vault_id = azurerm_key_vault.mystorekeeper-keyvault.id
}

resource "azurerm_key_vault_secret" "msk-dev-cosmosdb-secondary-connection" {
  name         = var.cosmosdb-connection-sttrings-key["secondary"]
  value        = local.cosmosdb_secondary_connection_string
  key_vault_id = azurerm_key_vault.mystorekeeper-keyvault.id
}