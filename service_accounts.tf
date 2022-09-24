resource "google_service_account" "connectionhub_account" {
  account_id   = "connection-hub-account"
  display_name = "Connection Hub Service Account"
}

resource "google_service_account_key" "connectionhub_key" {
  service_account_id = google_service_account.connectionhub_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}


