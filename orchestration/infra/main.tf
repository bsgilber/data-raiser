provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Enable specific Google API
resource "google_project_service" "composer_api" {
  project = var.project_id
  service = "composer.googleapis.com"

  disable_on_destroy = false
}
