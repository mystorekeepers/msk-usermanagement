
variable "msk-default-location" {
  type = string
}

variable "msk-subscription" {
  type = string
}

variable "msk-apigateway-resource-group" {
  type = string
}

variable "msk-apigateway-log-analytics" {
  type = object({
    ANALYTICS_WORKSPACE_NAME = string
    ANALYTICS_SKU            = string
    RETENTION_DAYS           = number
  })
}

variable "msk-apigateway-application-insight" {
  type = object({
    NAME             = string
    APPLICATION_TYPE = string
  })
}

variable "msk-apigateway-management" {
  type = object({
    NAME            = string
    PUBLISHER_NAME  = string
    PUBLISHER_EMAIL = string
    SKU_NAME        = string
    LOGER_NAME      = string
  })
}

variable "tags" {
  type = object({
    application-name = string
    deployed-by      = string
    purpose          = string
    role             = string
    mail             = string
    env              = string
  })
}