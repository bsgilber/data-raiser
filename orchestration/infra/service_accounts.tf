// Airflow
resource "google_service_account" "orchestration_owner" {
  account_id   = "svc-airflow-owner"
  display_name = "Custom Service Account for Airflow"
  provider     = google-beta

  project = var.project_id
}

resource "google_project_iam_member" "orchestration_iam" {
  project  = var.project_id
  provider = google-beta
  member   = format("serviceAccount:%s", google_service_account.orchestration_owner.email)
  // Role for Public IP environments
  role = "roles/composer.worker"
}
