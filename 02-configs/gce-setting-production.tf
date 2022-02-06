terraform {
  backend "gcs" {
    bucket  = "acd-prod-terraform-states"
    prefix = "acd-onix-gce"
  }
  required_providers {
    google = "3.76.0"
  }
}

provider "google" {
  project     = "acd-prod-291913"
  region      = "asia-southeast1"
}
