data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_firewall" "allow_caldera" {
  name      = "allow-caldera"
  network   = data.google_compute_network.default.name
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8888"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-caldera"]
}

resource "google_compute_firewall" "allow_dns" {
  name      = "allow-dns"
  network   = data.google_compute_network.default.name
  direction = "INGRESS"

  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-dns"]
}

resource "google_compute_firewall" "allow_outbound_tcp" {
  name      = "allow-outbound-tcp"
  network   = data.google_compute_network.default.name
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-outbound-tcp"]
}