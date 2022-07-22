

data "google_service_account" "msk-apigateway-service-account-id" {
  account_id = var.service-account-id
}

resource "google_api_gateway_api" "msk-prod-apigateway" {
  provider     = google-beta
  api_id       = "${var.msk-global-configurations["PROJECT"]}-prod-apigateway-id"
  display_name = "${var.msk-global-configurations["PROJECT"]} prod apigateway"
}


resource "google_api_gateway_api_config" "apigateway-prod-config" {
  provider = google-beta
  api      = google_api_gateway_api.msk-prod-apigateway.api_id

  display_name = "msk prod apigateway config"

  openapi_documents {
    document {
      path     = "openapi.yaml"
      contents = filebase64("../prod.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_api_config_iam_member" "gateway_prod-iam" {
  provider   = google-beta
  api        = google_api_gateway_api.msk-prod-apigateway.api_id
  api_config = google_api_gateway_api_config.apigateway-prod-config.api_config_id
  role       = "roles/apigateway.admin"
  member     = "serviceAccount:${data.google_service_account.msk-apigateway-service-account-id.email}"
}

resource "google_api_gateway_gateway" "api_devtest-gw" {
  provider   = google-beta
  api_config = google_api_gateway_api_config.apigateway-prod-config.id
  gateway_id = "${var.msk-global-configurations["PROJECT"]}-prod-gateway-id"
}

