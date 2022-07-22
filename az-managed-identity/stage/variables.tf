
variable "msk-subscription" {
  type = string
}

variable "msk-resource-group" {
  type = string
}

variable "msk-location" {
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

variable "managed-identity-name" {
  type = string
}
