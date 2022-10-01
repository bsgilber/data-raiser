// Metabase
resource "google_service_account" "metabase_dashboarding_owner" {
  account_id   = "svc-metabase-owner"
  project      = var.project_id
  display_name = "Metabase Dashboarding Service Account"
  description  = "Metabase Dashboarding service account"
}

resource "google_service_account_key" "metabase_dashboarding_account_key" {
  service_account_id = google_service_account.metabase_dashboarding_owner.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "metabase_account_json" {
  content  = base64decode(google_service_account_key.metabase_dashboarding_account_key.private_key)
  filename = "${path.module}/private/metabase.json"
}
