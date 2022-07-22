
variable "msk-global-configurations" {
  type = object({
    REGION  = string
    PROJECT = string
  })
}

variable "service-account-id" {
  type = string
}

variable "delete-stp-storage-bucket" {
  type = string
}

variable "entry_point" {
  type = string
}

variable "function-configurations" {
  type = object({
    source_dir          = string
    name                = string
    description         = string
    runtime             = string
    trigger_http        = string
    available_memory_mb = string
    output_path         = string
    type                = string
  })
}

variable "environment_variables" {
  type = object({
    PROJECT   = string
    KIND      = string
  })
}
