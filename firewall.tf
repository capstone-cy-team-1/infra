resource "google_compute_firewall" "attacker_allow_ssh" {
  name      = "attacker-allow-ssh"
  network   = google_compute_network.attacker_vpc.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["attacker-allow-ssh"]
}

resource "google_compute_firewall" "attacker_allow_caldera" {
  name      = "attacker-allow-caldera"
  network   = google_compute_network.attacker_vpc.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8888"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["attacker-allow-caldera"]
}

resource "google_compute_firewall" "attacker_allow_outbound_tcp" {
  name      = "attacker-allow-outbound-tcp"
  network   = google_compute_network.attacker_vpc.self_link
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["attacker-allow-outbound-tcp"]
}

resource "google_compute_firewall" "attacker_allow_dns" {
  name      = "attacker-allow-dns"
  network   = google_compute_network.attacker_vpc.self_link
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
  target_tags   = ["attacker-allow-dns"]
}

resource "google_compute_firewall" "victim_allow_ssh" {
  name      = "victim-allow-ssh"
  network   = google_compute_network.victim_vpc.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["victim-allow-ssh"]
}

resource "google_compute_firewall" "victim_allow_outbound_tcp" {
  name      = "victim-allow-outbound-tcp"
  network   = google_compute_network.victim_vpc.self_link
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "3000", "4873"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["victim-allow-outbound-tcp"]
}

resource "google_compute_firewall" "victim_allow_inbound_tcp" {
  name      = "victim-allow-inbound-tcp"
  network   = google_compute_network.victim_vpc.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "3000", "4873"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["victim-allow-inbound-tcp"]
}

resource "google_compute_firewall" "victim_allow_verdaccio" {
  name      = "victim-allow-verdaccio"
  network   = google_compute_network.victim_vpc.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["4873"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["victim-allow-verdaccio"]
}

resource "google_compute_firewall" "victim_web_deny_outbound" {
  name      = "victim-web-deny-outbound"
  network   = google_compute_network.victim_vpc.self_link
  direction = "EGRESS"



  deny {
    protocol = "all"
  }

  source_ranges      = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
  target_tags        = ["victim-web-deny-outbound"]
}