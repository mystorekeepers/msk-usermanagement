
msk-default-location = "West Europe"

msk-apigateway-resource-group = "msk-prod-apimanager"

msk-apigateway-log-analytics = {
  ANALYTICS_WORKSPACE_NAME = "msk-prod-apimanager"
  ANALYTICS_SKU            = "PerGB2018"
  RETENTION_DAYS           = 30
}

msk-apigateway-application-insight = {
  NAME             = "msk-prod-apimanager"
  APPLICATION_TYPE = "web"
}

msk-apigateway-management = {
  NAME            = "msk-prod"
  PUBLISHER_NAME  = "Owusu Bright Debrah"
  PUBLISHER_EMAIL = "owusubrightdebrah@gmail.com"
  SKU_NAME        = "Consumption_0"
  LOGER_NAME      = "msk-prod-apimanager"
}

tags = {
  application-name = "mystorekeeper"
  deployed-by      = "Owusu Bright Debrah"
  purpose          = "To protect and provide application webapis"
  role             = "cloud engineer"
  mail             = "owusubrightdebrah@gmail.com"
  env              = "prod"
}
