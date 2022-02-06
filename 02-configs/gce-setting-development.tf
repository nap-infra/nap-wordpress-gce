terraform {
  backend "gcs" {
    bucket  = "acd-dev-terraform-states"
    prefix = "acd-onix-gce"
  }
  required_providers {
    google = "3.76.0"
  }
}

provider "google" {
  project     = "acd-dev-291913"
  region      = "asia-southeast1"
}