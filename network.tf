resource "google_compute_network" "victim_vpc" {
  name                    = "capstone-victim-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_network" "attacker_vpc" {
  name                    = "capstone-attacker-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "victim_public_subnet" {
  name          = "victim-public-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.victim_vpc.self_link

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}

resource "google_compute_subnetwork" "victim_private_subnet" {
  name          = "victim-private-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.victim_vpc.self_link

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}

resource "google_compute_subnetwork" "attacker_subnet" {
  name          = "attacker-subnet"
  ip_cidr_range = "192.168.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.attacker_vpc.self_link

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}

resource "google_compute_router" "victim_nat_router" {
  name    = "victim-nat-router"
  region  = google_compute_subnetwork.victim_public_subnet.region
  network = google_compute_network.victim_vpc.self_link
}

resource "google_compute_router_nat" "victim_nat_config" {
  name                   = "victim-nat-config"
  router                 = google_compute_router.victim_nat_router.name
  region                 = google_compute_router.victim_nat_router.region
  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.victim_private_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_route" "victim_private_subnet_default_route" {
  name             = "victim-private-subnet-default-route"
  network          = google_compute_network.victim_vpc.self_link
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}