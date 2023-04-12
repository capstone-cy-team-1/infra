resource "google_compute_instance" "attacker_caldera_server" {
  name                      = "attacker-caldera-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["attacker-allow-caldera", "attacker-allow-outbound-tcp", "attacker-allow-ssh"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
    kms_key_self_link = google_kms_crypto_key.capstone_key.id
  }

  network_interface {
    network    = google_compute_network.attacker_vpc.self_link
    subnetwork = google_compute_subnetwork.attacker_subnet.self_link

    access_config {
    }
  }

  metadata = {
    "ssh-keys"             = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
      peterpsyllos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnoCRQ2vFZMyS/K+xCS5eLzEKcj9GOhllJk6X50nJ8D VPSs
     EOT
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata_startup_script = "echo hi > /test.txt"
}

resource "google_compute_instance" "attacker_dns_server" {
  name                      = "attacker-dns-server"
  machine_type              = "e2-micro"
  zone                      = "us-central1-a"
  tags                      = ["attacker-allow-dns", "attacker-allow-outbound-tcp", "attacker-allow-ssh"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
    kms_key_self_link = google_kms_crypto_key.capstone_key.id
  }

  network_interface {
    network    = google_compute_network.attacker_vpc.self_link
    subnetwork = google_compute_subnetwork.attacker_subnet.self_link
    access_config {
    }
  }

  metadata = {
    "ssh-keys"             = <<EOT
      nishantjain:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwxasd2BwkVvmGmQXAgZGAqPVF6+0tsNrPfthFTWxCj VPSs
      shreyasnair:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKanUfuuuebaukeQftTpQCXznVpSC7MGWR1JHBImZ97E VPSs
      parthshukla:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOdC0BXZzs2H3iAXbWf1YAJz+WEVPG+XvWtOOd15LLO VPSs
     EOT
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata_startup_script = "echo hi > /test.txt"
}