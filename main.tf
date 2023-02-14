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

resource "google_compute_instance" "web_server" {
  name                      = "web-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["http-server", "https-server"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    "ssh-keys" = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
     EOT
  }

  metadata_startup_script = "echo hi > /test.txt"
}

resource "google_compute_instance" "caldera_server" {
  name                      = "caldera-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["http-server", "https-server"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    "ssh-keys" = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
      peterpsyllos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnoCRQ2vFZMyS/K+xCS5eLzEKcj9GOhllJk6X50nJ8D VPSs
     EOT
  }

  metadata_startup_script = "echo hi > /test.txt"
}

resource "google_compute_instance" "dns_server" {
  name                      = "dns-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["http-server", "https-server"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    "ssh-keys" = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
      parthshukla:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOdC0BXZzs2H3iAXbWf1YAJz+WEVPG+XvWtOOd15LLO VPSs
     EOT
  }

  metadata_startup_script = "echo hi > /test.txt"
}