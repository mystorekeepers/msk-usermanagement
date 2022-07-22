
variable "msk-default-location" {
  type        = string
}

variable "msk-subscription" {
  type        = string
}

variable "cosmosdb-sqlapi-configurations" {
  type = object({
    resource_group_name   = string
    cosmosdb_account_name = string
    offer_type            = string
    kind                  = string
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