resource "google_service_account" "viewer" {
  account_id   = "viewer"
  display_name = "Service Account for viewer"
}

resource "google_project_iam_member" "viewer" {
  for_each = toset([
    "viewer",
    "artifactregistry.reader"
  ])
  project = var.project
  role    = "roles/${each.key}"
  member  = "serviceAccount:${google_service_account.viewer.email}"
}

resource "google_service_account_iam_binding" "viewer" {
  service_account_id = google_service_account.viewer.name
  role               = "roles/iam.serviceAccountUser"
  members = [
    "user:hnlee@tecacecloud.com"
  ]
}

