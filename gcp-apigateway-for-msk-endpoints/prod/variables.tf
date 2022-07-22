
variable "msk-global-configurations" {
  type = object({
    REGION  = string
    PROJECT = string
  })
}

variable "msk-tags" {
  type = object({
    CONTACT = string
    ROLE    = string
    NAME    = string
  })
}

variable "service-account-id" {
  type = string
}
