resource "google_artifact_registry_repository" "gi-repo" {
  location      = var.region
  repository_id = "gi-repo"
  description   = "gi docker repository and helm repo"
  format        = "DOCKER"
}



resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-v5"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.id
  workload_identity_pool_provider_id = "github-v5"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
