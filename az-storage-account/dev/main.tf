
data "azurerm_user_assigned_identity" "msk-stage-user-managed-identity" {
  name                = var.msk-stage-managed-identity["managed-identity-name"]
  resource_group_name = var.msk-stage-managed-identity["managed-identity-resource-group"]
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "msk-dev-storage-account-resource-group" {
  name     = var.msk-storage-account-resource-group
  location = var.msk-default-location
   tags = {
    "name"             = var.msk-storage-account-resource-group
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_storage_account" "msk-dev-storage-account" {
  name                      = var.msk-storage-account-name
  resource_group_name       = azurerm_resource_group.msk-dev-storage-account-resource-group.name
  location                  = azurerm_resource_group.msk-dev-storage-account-resource-group.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  allow_blob_public_access  = true
  blob_properties {
    cors_rule {
      allowed_origins    = ["*"]
      allowed_methods    = ["DELETE", "GET", "HEAD", "POST", "OPTIONS", "PUT"]
      allowed_headers    = ["DELETE", "GET", "HEAD", "POST", "OPTIONS", "PUT"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 30
    }
    versioning_enabled = true
  }
    static_website {
      index_document = "index.html"
  }
   tags = {
    "name"             = var.msk-storage-account-name
    "application name" = var.tags["application-name"]
    "deployed by"      = var.tags["deployed-by"]
    "role"             = var.tags["role"]
    "mail"             = var.tags["mail"]
    "env"              = var.tags["env"]
  }
}

resource "azurerm_storage_container" "msk-dev-storage-account-container" {
  for_each              = toset(var.msk-list-of-storage-account-container-names)
  name                  = each.key
  storage_account_name  = azurerm_storage_account.msk-dev-storage-account.name
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.msk-dev-storage-account
  ]
}

resource "azurerm_storage_table" "msk-dev-storage-account-table" {
  for_each              = toset(var.msk-list-of-storage-account-table-names)
  name                  = each.key
  storage_account_name = azurerm_storage_account.msk-dev-storage-account.name
}


resource "azurerm_role_assignment" "assign-storage-table-contributor-role-to-user-managed-identity" {
  scope                = azurerm_storage_account.msk-dev-storage-account.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = data.azurerm_user_assigned_identity.msk-stage-user-managed-identity.principal_id
}

resource "azurerm_role_assignment" "assign-storage-blob-data-contributor-role-to-user-managed-identity" {
  scope                = azurerm_storage_account.msk-dev-storage-account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_user_assigned_identity.msk-stage-user-managed-identity.principal_id
}

resource "azurerm_role_assignment" "assign-storage-table-contributor-role-to-developer-working-locally" {
  scope                = azurerm_storage_account.msk-dev-storage-account.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         =  data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "assign-storage-blob-data-contributor-role-to-developer-working-locally" {
  scope                = azurerm_storage_account.msk-dev-storage-account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         =  data.azurerm_client_config.current.object_id
}