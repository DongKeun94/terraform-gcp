resource "google_service_account" "devops" {
  account_id   = "devops"
  display_name = "Service Account for devops"
}

resource "google_project_iam_member" "devops" {
  for_each = toset([
    "editor",
    "artifactregistry.admin",
  ])
  project = var.project
  role    = "roles/${each.key}"
  member  = "serviceAccount:${google_service_account.devops.email}"
}

resource "google_service_account_iam_binding" "devops" {
  for_each = toset([
    "iam.serviceAccountUser",
    "iam.workloadIdentityUser"
  ])
  service_account_id = google_service_account.devops.name
  role               = "roles/${each.key}"
  members = [
    "user:dksung@tecacecloud.com",
    #"principal://iam.googleapis.com/projects/${var.project}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github.id}/subject/assertion.sub"
  ]
}

