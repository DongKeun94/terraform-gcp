resource "google_service_account" "devops" {
  account_id   = "devops"
  display_name = "Service Account for devops"
}

resource "google_project_iam_member" "devops" {
  for_each = toset([
    "editor"
  ])
  project = var.project
  role    = "roles/${each.key}"
  member  = "serviceAccount:${google_service_account.devops.email}"
}

resource "google_service_account_iam_binding" "devops" {
  service_account_id = google_service_account.devops.name
  role               = "roles/iam.serviceAccountUser"
  members = [
    "user:dksung@tecacecloud.com"
  ]
}

