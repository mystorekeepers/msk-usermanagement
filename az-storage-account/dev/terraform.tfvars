
msk-default-location = "West Europe"

msk-storage-account-resource-group = "msk-dev-storage-account"

msk-storage-account-name = "mskdevstorage428"

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
  env              = "dev"
}

msk-stage-managed-identity = {
  managed-identity-name = "msk-stage-managed-identity"
  managed-identity-resource-group = "msk-stage-managed-identity"
}