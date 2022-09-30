// dbt
resource "google_service_account" "warehouse_transformation_owner" {
  account_id   = "svc-dbt-owner"
  project      = var.project_id
  display_name = "dbt Service Account"
  description  = "dbt service account"
}
