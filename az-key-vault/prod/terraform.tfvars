
msk-resource-group = "msk-prod-keyvault"

msk-location = "West Europe"

msk-key-vault-config = {
  NAME                       = "msk-prod"
  SKU_NAME                   = "standard"
  ENABLE_DISK_ENCRYPTION     = true
  PURGE_PROTECTION_ENABLE    = false
  SOFT_DELETE_RETENTION_DAYS = 7
}

tags = {
  application-name = "mystorekeeper"
  deployed-by      = "Owusu Bright Debrah"
  role             = "cloud engineer"
  mail             = "owusubrightdebrah@gmail.com"
  env              = "prod"
}

msk-prod-managed-identity = {
  managed-identity-name           = "msk-prod-managed-identity"
  managed-identity-resource-group = "msk-prod-managed-identity"
}

msk-prod-cosmosdb-configurations = {
  cosmosdb-name       = "msk-prod-55337"
  resource_group_name = "msk-prod-cosmosdb"
}

cosmosdb-connection-sttrings-key = {
  primary   = "msk-primary-key"
  secondary = "msk-secondary-key"
}
