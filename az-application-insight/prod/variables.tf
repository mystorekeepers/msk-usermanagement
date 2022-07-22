
variable "msk-subscription" {
  type = string
}

variable "msk-application-insight-resource-group" {
  type = string
}

variable "msk-default-location" {
  type = string
}

variable "msk-application-insight-name" {
  type = string
}

variable "msk-application-insight-type" {
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