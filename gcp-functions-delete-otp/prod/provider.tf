
terraform {

  backend "gcs" {
    bucket  = "msk-terraform"
    prefix  = "terraform/state/cloudfunction/prod-delete-otp.tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.90.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>3.90.0"
    }
  }

}

provider "google" {
  project = var.msk-global-configurations["PROJECT"]
  region  = var.msk-global-configurations["REGION"]
}

provider "google-beta" {
  project = var.msk-global-configurations["PROJECT"]
  region  = var.msk-global-configurations["REGION"]
}