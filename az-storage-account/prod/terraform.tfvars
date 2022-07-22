
msk-default-location = "West Europe"

msk-storage-account-resource-group = "msk-prod-storage-account"

msk-storage-account-name = "mskprodstorage428"

msk-list-of-storage-account-container-names = ["users-profile","products-profile"]

msk-list-of-storage-account-table-names = [
  "mskEmployees",
  "mskOrganization",
  "mskSubscription",
  "mskRegisteredUsers",
  "mskTag",
  "mskCategory",
  "mskWarehouse",
  "mskUsersRoles",
  "mskUsersLogin"
]

tags = {
  application-name = "mystorekeeper"
  deployed-by      = "Owusu Bright Debrah"
  role             = "cloud engineer"
  mail             = "owusubrightdebrah@gmail.com"
  env              = "prod"
}

msk-prod-managed-identity = {
  managed-identity-name = "msk-prod-managed-identity"
  managed-identity-resource-group = "msk-prod-managed-identity"
}