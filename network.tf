resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = "${var.env}-vpc"
  mtu                     = 1460
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_bastion" {
  provider                 = google
  name                     = "subnet-bastion"
  region                   = var.region
  ip_cidr_range            = "10.1.0.0/16"
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}
/*
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = google_compute_network.vpc_network.id
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name= google_compute_subnetwork.subnet_gke.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
*/

resource "google_compute_subnetwork" "subnet_gke" {
  provider      = google
  name          = "subnet-gke"
  region        = var.region
  ip_cidr_range = "10.3.0.0/16"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range = [
    {
      range_name    = "gke-pod"
      ip_cidr_range = "10.101.0.0/16"
    },
    {
      range_name    = "gke-service"
      ip_cidr_range = "10.102.0.0/16"
    }
  ]
}
