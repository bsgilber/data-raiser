provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "bigquery_api" {
  project = var.project_id
  service = "bigquery.googleapis.com"

  disable_on_destroy = false
}
