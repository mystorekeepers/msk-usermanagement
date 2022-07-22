
msk-global-configurations = {
  REGION  = "europe-west2"
  PROJECT = "mystorekeeper"
}

msk-service-account-iam-role = [
  "roles/cloudfunctions.invoker",
  "roles/datastore.owner",
  "roles/workflows.admin",
  "roles/secretmanager.admin",
  "roles/storage.admin",
  "roles/logging.admin",
  "roles/secretmanager.secretAccessor",
  "roles/run.invoker",
  "roles/apigateway.admin"
]

msk-service-account-description = "mystorekeeper service account to access other gcp services"

msk-service-account-id = "mystorekeeper"