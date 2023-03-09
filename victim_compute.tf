resource "google_compute_instance" "victim_dev_server" {
  name                      = "victim-dev-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["victim-allow-outbound-tcp", "victim-allow-ssh"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = google_compute_network.victim_vpc.self_link
    subnetwork = google_compute_subnetwork.victim_private_subnet.self_link

  }

  metadata = {
    "ssh-keys" = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
     EOT
  }

  metadata_startup_script = "echo hi > /test.txt"
}

resource "google_compute_instance" "victim_web_server" {
  name                      = "victim-web-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["https-server", "http-server", "victim-allow-ssh"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = google_compute_network.victim_vpc.self_link
    subnetwork = google_compute_subnetwork.victim_public_subnet.self_link

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

resource "google_compute_instance" "victim_verdaccio_server" {
  name                      = "victim-verdaccio-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["victim-allow-outbound-tcp"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = google_compute_network.victim_vpc.self_link
    subnetwork = google_compute_subnetwork.victim_private_subnet.self_link

  }

  metadata = {
    "ssh-keys" = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
     EOT
  }

  metadata_startup_script = "echo hi > /test.txt"
}