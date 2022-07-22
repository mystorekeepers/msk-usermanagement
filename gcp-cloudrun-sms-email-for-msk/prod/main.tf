
data "google_service_account" "msk-apigateway-service-account-id" {
  account_id = var.service-account-id
}

resource "google_cloud_run_service" "msk-sms-email-notification" {
  name     = var.image-and-cloudrun-name
  location = var.msk-global-configurations["REGION"]
  template {
    spec {
      service_account_name = data.google_service_account.msk-apigateway-service-account-id.email

      containers {
        image = "gcr.io/${var.msk-global-configurations["PROJECT"]}/${var.image-and-cloudrun-name}:latest"
        env {
          name  = "PROJECT"
          value = var.msk-global-configurations["PROJECT"]
        }
      }
    }
  }

  metadata {
    annotations = {
      generated-by = "magic-modules"
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  autogenerate_revision_name = true

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
    ]
  }
}
