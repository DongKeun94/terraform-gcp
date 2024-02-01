resource "google_project_organization_policy" "vm_external_ip_access_policy" {
  project    = var.project
  constraint = "compute.vmExternalIpAccess"

  list_policy {
    allow {
      all = true  
      /*values = [
        "projects/${var.project}/zones/${var.zone[0]}/instances/${var.bastion}"
      ]*/
    }
  }
}

resource "google_compute_address" "external_bastion_ip" {
  name   = "bastion-ext"
  region = var.region
}

resource "google_compute_instance" "bastion_instance" {
  name         = var.bastion
  machine_type = "n2-standard-2"
  zone         = var.zone[1]
  depends_on = [google_project_organization_policy.vm_external_ip_access_policy]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_bastion.id
    access_config {
      nat_ip = google_compute_address.external_bastion_ip.address
    }
  }

  service_account {
    email  = google_service_account.devops.email
    scopes = ["cloud-platform"]
  }

}