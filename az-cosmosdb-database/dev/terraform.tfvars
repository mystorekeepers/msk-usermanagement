
msk-default-location = "West Europe"

cosmosdb-sqlapi-configurations = {
  resource_group_name   = "msk-dev-cosmosdb"
  cosmosdb_account_name = "msk-dev"
  offer_type            = "Standard"
  kind                  = "GlobalDocumentDB"
}


tags = {
  application-name = "mystorekeeper"
  deployed-by      = "Owusu Bright Debrah"
  role             = "cloud engineer"
  mail             = "owusubrightdebrah@gmail.com"
  env              = "dev"
}
