
# SMS apikey

resource "google_secret_manager_secret" "msk-sms-apikey-key" {
  secret_id = var.sms-from-arkesel-apikey-key-and-value-pair["key"]

  labels = {
    name             = var.sms-from-arkesel-apikey-key-and-value-pair["key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "msk-sms-apikey-value" {
  secret      = google_secret_manager_secret.msk-sms-apikey-key.id
  secret_data = var.sms-from-arkesel-apikey-key-and-value-pair["value"]
}

# MSK EMAIL

resource "google_secret_manager_secret" "msk-email-notification-key" {
  secret_id = var.email-for-sending-notifications-to-client["email_key"]

  labels = {
    name             = var.email-for-sending-notifications-to-client["email_key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "msk-sms-apikey" {
  secret      = google_secret_manager_secret.msk-email-notification-key.id
  secret_data = var.email-for-sending-notifications-to-client["email_value"]
}

# MSK EMAIL PASSWORD

resource "google_secret_manager_secret" "msk-email-password-notification-key" {
  secret_id = var.email-for-sending-notifications-to-client["email_password_key"]

  labels = {
    name             = var.email-for-sending-notifications-to-client["email_password_key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "msk-email-password-notification-value" {
  secret      = google_secret_manager_secret.msk-email-password-notification-key.id
  secret_data = var.email-for-sending-notifications-to-client["email_password_value"]
}

# Azure storage account key

resource "google_secret_manager_secret" "azure-storage-account-key" {
  secret_id = var.azure-storage-account-key["storage_secret_key"]

  labels = {
    name             = var.azure-storage-account-key["storage_secret_key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "azure-storage-account-key-value" {
  secret      = google_secret_manager_secret.azure-storage-account-key.id
  secret_data = var.azure-storage-account-key["storage_secret_value"]
}

# API Gateway url

resource "google_secret_manager_secret" "apigateway-url-key" {
  secret_id = var.apigateway-url["key"]

  labels = {
    name             = var.apigateway-url["key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "apigateway-url-value" {
  secret      = google_secret_manager_secret.apigateway-url-key.id
  secret_data = var.apigateway-url["value"]
}

# Api Gateway Key

resource "google_secret_manager_secret" "apigateway-apikey-key" {
  secret_id = var.apigateway-apikey["key"]

  labels = {
    name             = var.apigateway-apikey["key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "apigateway-apikey-value" {
  secret      = google_secret_manager_secret.apigateway-apikey-key.id
  secret_data = var.apigateway-apikey["value"]
}

# jwt expiration time in seconds

resource "google_secret_manager_secret" "jwt-expiration-time-in-seconds-key" {
  secret_id = var.jwt-expiration-time-in-seconds["key"]

  labels = {
    name             = var.jwt-expiration-time-in-seconds["key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "jwt-expiration-time-in-seconds-value" {
  secret      = google_secret_manager_secret.jwt-expiration-time-in-seconds-key.id
  secret_data = var.jwt-expiration-time-in-seconds["value"]
}

# jwt secrets for generating bearer tokens

resource "google_secret_manager_secret" "jwt-secrets-for-generating-bearer-tokens-key" {
  secret_id = var.jwt-secrets-for-generating-bearer-tokens["key"]

  labels = {
    name             = var.jwt-secrets-for-generating-bearer-tokens["key"]
    application-name = var.msk-tags["APPLICATION-NAME"]
    deployed-by      = var.msk-tags["DEPLOYED-BY"]
    contact          = var.msk-tags["CONTACT"]
    role             = var.msk-tags["ROLE"]
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "jwt-secrets-for-generating-bearer-tokens-value" {
  secret      = google_secret_manager_secret.jwt-secrets-for-generating-bearer-tokens-key.id
  secret_data = var.jwt-secrets-for-generating-bearer-tokens["value"]
}