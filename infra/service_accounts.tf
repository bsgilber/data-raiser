// Airbyte
resource "google_service_account" "connectionhub_account" {
  account_id   = "connection-hub-account"
  display_name = "Connection Hub Service Account"
}

resource "google_service_account_key" "connectionhub_key" {
  service_account_id = google_service_account.connectionhub_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}


// Airflow
resource "google_service_account" "airflow_service_account" {
  account_id   = "airflow-service-account"
  display_name = "Custom Service Account for Airflow"
}

resource "google_project_iam_member" "airflow_sa_iam" {
  project = var.project_id
  member  = format("serviceAccount:%s", google_service_account.airflow_service_account.email)
  // Role for Public IP environments
  role = "roles/composer.worker"
}

resource "google_service_account_iam_member" "airflow_sa_iam" {
  service_account_id = google_service_account.airflow_service_account.name
  role               = "roles/composer.ServiceAgentV2Ext"
  member             = format("serviceAccount:%s", google_service_account.airflow_service_account.email)
}
