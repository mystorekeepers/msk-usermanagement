
data "google_service_account" "msk-apigateway-service-account-id" {
  account_id = var.service-account-id
}

resource "google_storage_bucket" "msk-delete-otp-storage-bucket" {
  name = var.delete-stp-storage-bucket
}

data "archive_file" "src" {
  type        = var.function-configurations["type"]
  source_dir  = var.function-configurations["source_dir"]
  output_path = var.function-configurations["output_path"]
}

resource "google_storage_bucket_object" "archive" {
  name   = "${data.archive_file.src.output_md5}.zip"
  bucket = google_storage_bucket.msk-delete-otp-storage-bucket.name
  source = var.function-configurations["output_path"]
}

resource "google_cloudfunctions_function" "function" {
  name        = var.function-configurations["name"]
  description = var.function-configurations["description"]
  runtime     = var.function-configurations["runtime"]
  region      = var.msk-global-configurations["REGION"]

  available_memory_mb   = var.function-configurations["available_memory_mb"]
  trigger_http          = var.function-configurations["trigger_http"]
  entry_point           = var.entry_point
  source_archive_bucket = google_storage_bucket.msk-delete-otp-storage-bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  environment_variables = var.environment_variables

  service_account_email = data.google_service_account.msk-apigateway-service-account-id.email

}
