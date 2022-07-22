
msk-default-location = "West Europe"

msk-apigateway-resource-group = "msk-stage-apimanager"

msk-apigateway-log-analytics = {
  ANALYTICS_WORKSPACE_NAME = "msk-stage-apimanager"
  ANALYTICS_SKU            = "PerGB2018"
  RETENTION_DAYS           = 30
}

msk-apigateway-application-insight = {
  NAME             = "msk-stage-apimanager"
  APPLICATION_TYPE = "web"
}

msk-apigateway-management = {
  NAME            = "msk-stage"
  PUBLISHER_NAME  = "Owusu Bright Debrah"
  PUBLISHER_EMAIL = "owusubrightdebrah@gmail.com"
  SKU_NAME        = "Consumption_0"
  LOGER_NAME      = "msk-stage-apimanager"
}

tags = {
  application-name = "mystorekeeper"
  deployed-by      = "Owusu Bright Debrah"
  purpose          = "To protect and provide application webapis"
  role             = "cloud engineer"
  mail             = "owusubrightdebrah@gmail.com"
  env              = "stage"
}
