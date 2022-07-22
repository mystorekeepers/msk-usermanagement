
variable "msk-default-location" {
  type = string
}

variable "msk-dns-resource-group" {
  type = string
}

variable "msk-subscription" {
  type = string
}

variable "cdn-name" {
  type = string
}

variable "cdn-sku" {
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


