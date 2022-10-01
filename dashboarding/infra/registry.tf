resource "google_artifact_registry_repository" "artifact-repo" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repository_id
  description   = "example docker repository"
  format        = "DOCKER"
}


