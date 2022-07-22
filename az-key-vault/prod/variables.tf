
variable "msk-subscription" {
  type = string
}

variable "msk-resource-group" {
  type = string
}

variable "msk-location" {
  type = string
}

variable "msk-key-vault-config" {
  type = object({
    NAME                       = string
    SKU_NAME                   = string
    ENABLE_DISK_ENCRYPTION     = bool
    PURGE_PROTECTION_ENABLE    = bool
    SOFT_DELETE_RETENTION_DAYS = number
  })
}

variable "tags" {
  type = object({
    application-name = string
    deployed-by      = string
    role             = string
    mail             = string
    env              = string
  })
}

variable "msk-prod-managed-identity" {
  type = object({
    managed-identity-name           = string
    managed-identity-resource-group = string
  })
}

variable "cosmosdb-connection-sttrings-key" {
  type = object({
    primary   = string
    secondary = string
  })
}

variable "msk-prod-cosmosdb-configurations" {
  type = object({
    cosmosdb-name       = string
    resource_group_name = string
  })
}