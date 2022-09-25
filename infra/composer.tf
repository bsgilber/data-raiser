resource "google_composer_environment" "composer_environment" {
  provider = google-beta
  name = "compose-the-rose"

  config {
    software_config {
      image_version = var.airflow_image
    }

    node_config {
      service_account = google_service_account.airflow_service_account.email
    }

  }
}
