
variable "msk-subscription" {
  type = string
}

variable "msk-function-resource-group" {
  type = string
}

variable "msk-default-location" {
  type = string
}

variable "msk-function-storage-account" {
  type = string
}

variable "msk-service-plan-name" {
  type = string
}

variable "msk-function-app-name" {
  type = string
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

variable "application-insight-resource-group-and-name" {
  type = object({
    application-insight-name                = string
    application-insight-resource-group-name = string
  })
}

variable "storage-account-container-and-resource-group" {
  type = object({
    storage-account-name           = string
    storage-account-resource-group = string
  })
}

variable "managed-identity-resource-group-and-name" {
  type = object({
    managed-identity-resource-group = string
    managed-identity-name           = string
  })
}
