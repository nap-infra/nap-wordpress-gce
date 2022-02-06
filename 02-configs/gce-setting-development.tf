terraform {
  backend "gcs" {
    bucket  = "nap-dev-terraform-states"
    prefix = "nap-wordpress-gce"
  }
  required_providers {
    google = "3.76.0"
  }
}

provider "google" {
  project     = "nap-devops-nonprod"
  region      = "asia-southeast1"
}