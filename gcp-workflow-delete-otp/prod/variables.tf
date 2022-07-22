
variable "msk-global-configurations" {
  type = object({
    REGION  = string
    PROJECT = string
  })
}

variable "msk-service-account-id" {
  type = string
}

variable "workflow-name" {
  type = string
}

variable "workflow-description" {
  type = string
}