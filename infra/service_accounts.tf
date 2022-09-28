// Ingestion Owner
resource "google_service_account" "ingestion_owner" {
  account_id   = "svc-airbyte-owner"
  display_name = "Connection Hub Service Account"

  project = var.project_id
}

resource "google_service_account_key" "ingestion_account_key" {
  service_account_id = google_service_account.ingestion_owner.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

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

// Bigquery Owner
resource "google_service_account" "warehouse_owner" {
  account_id = "svc-bigquery-owner"
  project    = var.project_id
}

// dbt
resource "google_service_account" "warehouse_transformation_owner" {
  account_id   = "svc-dbt-owner"
  project      = var.project_id
  display_name = "dbt Service Account"
  description  = "dbt service account"
}
