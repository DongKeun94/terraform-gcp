resource "google_compute_firewall" "allow_ssh_bastion" {
  name        = "allow-ssh"
  network     = google_compute_network.vpc_network.id
  description = "allow ssh bastion from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion"]
}