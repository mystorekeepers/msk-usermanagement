
msk-resource-group = "msk-dev-keyvault"

msk-location = "West Europe"

msk-key-vault-config = {
  NAME                       = "msk-dev"
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
  env              = "dev"
}

msk-stage-managed-identity = {
  managed-identity-name           = "msk-stage-managed-identity"
  managed-identity-resource-group = "msk-stage-managed-identity"
}

msk-dev-cosmosdb-configurations = {
  cosmosdb-name       = "msk-dev-30857"
  resource_group_name = "msk-dev-cosmosdb"
}

cosmosdb-connection-sttrings-key = {
  primary   = "msk-primary-key"
  secondary = "msk-secondary-key"
}
