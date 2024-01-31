resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = "${var.env}-vpc"
  mtu                     = 1460
  routing_mode = "GLOBAL"
}