resource "google_bigquery_dataset" "analytics" {
  dataset_id                  = format("analytics_%s", var.env)
  friendly_name               = format("analytics_%s", var.env)
  description                 = format("Analytics database for [%s] env.", var.env)
  location                    = "US"
  default_table_expiration_ms = 3600000

  labels = {
    env = var.env
  }
}

data "google_iam_policy" "owner" {
  binding {
    role = "roles/bigquery.dataOwner"

    members = [
      "user:bsgilber@gmail.com",
    ]
  }
}

resource "google_bigquery_dataset_iam_policy" "dataset" {
  dataset_id  = google_bigquery_dataset.analytics.dataset_id
  policy_data = data.google_iam_policy.owner.policy_data
}
