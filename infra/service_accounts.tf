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


// Braze
resource "google_project_iam_custom_role" "braze_ingestion_role" {
  role_id     = "braze_ingestion_role"
  title       = "Braze Ingestion"
  description = "Permissions for Braze to push data to storage."
  permissions = ["storage.objects.create", "storage.buckets.get"]
}

resource "google_service_account" "braze_ingestion_owner" {
  account_id   = "svc-braze-ingestion-owner"
  project      = var.project_id
  display_name = "Braze Ingestion Service Account"
  description  = "Braze Ingestion service account"
}

resource "google_project_iam_member" "braze_ingestion_iam" {
  project  = var.project_id
  provider = google-beta
  member   = format("serviceAccount:%s", google_service_account.braze_ingestion_owner.email)
  role     = google_service_account.braze_ingestion_owner.id
}

resource "google_service_account_key" "braze_ingestion_account_key" {
  service_account_id = google_service_account.braze_ingestion_owner.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "braze_account_json" {
  content  = base64decode(google_service_account_key.braze_ingestion_account_key.private_key)
  filename = "${path.module}/private/braze.json"
}
