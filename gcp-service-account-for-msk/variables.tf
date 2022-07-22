
variable "msk-global-configurations" {
  type = object({
    REGION  = string
    PROJECT = string
  })
}

variable "msk-service-account-id" {
  type = string
}

variable "msk-service-account-description" {
  type = string
}

variable "msk-service-account-iam-role" {
  type = list(string)
}

