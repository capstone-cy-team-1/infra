resource "google_compute_instance" "victim_dev_server" {
  name                      = "victim-dev-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["victim-allow-outbound-tcp", "victim-allow-ssh", "victim-allow-inbound-tcp"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
    kms_key_self_link = google_kms_crypto_key.capstone_key.id
  }

  network_interface {
    network    = google_compute_network.victim_vpc.self_link
    subnetwork = google_compute_subnetwork.victim_private_subnet.self_link

  }

  metadata = {
    "ssh-keys"             = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
      internal:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfdxRHYURRnt8JzXJz7/thAyZE8HswvbgbyODN+4Lyf internalSSH
     EOT
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata_startup_script = "echo hi > /test.txt"
}

resource "google_compute_instance" "victim_web_server" {
  name                      = "victim-web-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["https-server", "http-server", "victim-allow-ssh", "victim-allow-inbound-tcp"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
    kms_key_self_link = google_kms_crypto_key.capstone_key.id
  }

  network_interface {
    network    = google_compute_network.victim_vpc.self_link
    subnetwork = google_compute_subnetwork.victim_public_subnet.self_link

    access_config {
    }
  }

  metadata = {
    "ssh-keys"             = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
     EOT
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata_startup_script = "echo hi > /test.txt"
}

resource "google_compute_instance" "victim_verdaccio_server" {
  name                      = "victim-verdaccio-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["victim-allow-outbound-tcp", "victim-allow-ssh", "victim-allow-verdaccio", "victim-allow-inbound-tcp"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
    kms_key_self_link = google_kms_crypto_key.capstone_key.id
  }

  network_interface {
    network    = google_compute_network.victim_vpc.self_link
    subnetwork = google_compute_subnetwork.victim_private_subnet.self_link

  }

  metadata = {
    "ssh-keys"             = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
      internal:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfdxRHYURRnt8JzXJz7/thAyZE8HswvbgbyODN+4Lyf internalSSH
     EOT
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata_startup_script = "echo hi > /test.txt"
}