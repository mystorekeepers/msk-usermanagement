
variable "msk-default-location" {
  type = string
}

variable "msk-subscription" {
  type = string
}

variable "msk-storage-account-resource-group" {
  type = string
}

variable "msk-storage-account-name" {
  type = string
}

variable "msk-list-of-storage-account-container-names" {
  type = list(string)
}

variable "msk-list-of-storage-account-table-names" {
  type = list(string)
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

variable "msk-stage-managed-identity" {
  type = object({
    managed-identity-name           = string
    managed-identity-resource-group = string
  })
}
