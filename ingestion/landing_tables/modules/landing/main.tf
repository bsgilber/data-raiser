// Destination in Bigquery table
resource "google_bigquery_table" "landing_table" {
  dataset_id    = var.dataset_id
  table_id      = var.table_name
  friendly_name = var.table_name

  time_partitioning {
    type = var.time_partitioning_type
  }

  labels = {
    env = var.env
  }

  schema = var.schema_file
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/bigquery.dataOwner"
    members = [
      "user:bsgilber@gmail.com",
    ]
  }
}

resource "google_bigquery_table_iam_policy" "policy" {
  project     = var.project_id
  dataset_id  = var.dataset_id
  table_id    = google_bigquery_table.landing_table.table_id
  policy_data = data.google_iam_policy.admin.policy_data
}

