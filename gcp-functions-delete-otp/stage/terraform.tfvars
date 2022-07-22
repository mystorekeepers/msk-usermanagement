
msk-global-configurations = {
  REGION  = "us-central1"
  PROJECT = "mystorekeeper"
}

function-name = "msk-stage-delete-otp"

service-account-id = "mystorekeeper"

delete-stp-storage-bucket = "stage-delete-otp"

entry_point = "deleteOtpToken"

function-configurations = {
  name                = "msk-stage-delete-otp"
  description         = "mystorekeeper delete otp stage function"
  runtime             = "python39"
  trigger_http        = true
  available_memory_mb = 128
  output_path         = "../../../delete-otp/src.zip"
  source_dir          = "../../../delete-otp/gcp"
  type                = "zip"
}

environment_variables = {
    PROJECT   = "mystorekeeper"
    KIND      = "MSK_otp"
}