
variable "msk-global-configurations" {
  type = object({
    REGION  = string
    PROJECT = string
  })
}

variable "msk-tags" {
  type = object({
    CONTACT          = string
    ROLE             = string
    DEPLOYED-BY      = string
    APPLICATION-NAME = string
  })
}

variable "sms-from-arkesel-apikey-key-and-value-pair" {
  type = object({
    key   = string
    value = string
  })
}

variable "email-for-sending-notifications-to-client" {
  type = object({
    email_key            = string
    email_value          = string
    email_password_key   = string
    email_password_value = string
  })
}

variable "azure-storage-account-key" {
  type = object({
    storage_secret_key   = string
    storage_secret_value = string
  })
}

variable "apigateway-url" {
  type = object({
    key   = string
    value = string
  })
}

variable "apigateway-apikey" {
  type = object({
    key   = string
    value = string
  })
}

variable "jwt-expiration-time-in-seconds" {
  type = object({
    key   = string
    value = string
  })
}

variable "jwt-secrets-for-generating-bearer-tokens" {
  type = object({
    key   = string
    value = string
  })
}

