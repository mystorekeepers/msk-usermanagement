msk-default-location = "West Europe"

msk-function-resource-group = "msk-prod-add-employees"

msk-function-storage-account = "mskprodaddemp"

msk-service-plan-name = "msk-prod-add-employees"

msk-function-app-name = "msk-prod-add-employees"

tags = {
  application-name = "mystorekeeper"
  deployed-by      = "Owusu Bright Debrah"
  role             = "cloud engineer"
  mail             = "owusubrightdebrah@gmail.com"
  env              = "prod"
}

application-insight-resource-group-and-name = {
  application-insight-name                = "msk-prod-functionapps"
  application-insight-resource-group-name = "msk-prod-application-insight"
}

storage-account-container-and-resource-group = {
    storage-account-name           = "mskprodstorage428"
    storage-account-resource-group = "msk-prod-storage-account"
}

managed-identity-resource-group-and-name = {
  managed-identity-resource-group = "msk-prod-managed-identity"
  managed-identity-name           = "msk-prod-managed-identity"
}

