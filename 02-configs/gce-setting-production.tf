terraform {
  backend "gcs" {
    bucket  = "nap-prod-terraform-states"
    prefix = "nap-wordpress-gce"
  }
  required_providers {
    google = "3.76.0"
  }
}

provider "google" {
  project     = "nap-devops-prod"
  region      = "asia-southeast1"
}
