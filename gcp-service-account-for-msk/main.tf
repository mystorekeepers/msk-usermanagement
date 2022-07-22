
resource "google_service_account" "msk-apigateway-service-account" {
  account_id   = var.msk-service-account-id
  display_name = var.msk-service-account-description
}

resource "google_project_iam_member" "msk-apigateway-service-account-role" {
  for_each = toset(var.msk-service-account-iam-role)
  project  = var.msk-global-configurations["PROJECT"]
  role     = each.key
  member   = "serviceAccount:${google_service_account.msk-apigateway-service-account.email}"
}

