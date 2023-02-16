terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("../booming-splicer-377322-d32768c8c47e.json")
  project     = "booming-splicer-377322"
  region      = "us-central1"
  zone        = "us-central1-a"
}