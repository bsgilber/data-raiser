resource "google_bigquery_dataset" "raw" {
  dataset_id    = format("raw_%s", var.env)
  friendly_name = format("raw_%s", var.env)
  description   = format("Dataset for raw data, loaded directly from GCS for [%s] env.", var.env)
  project       = var.project_id
  location      = var.region

  labels = {
    env = var.env
  }

  # Order of access matters
  # WRITER -> OWNER -> READER
  #   access {
  #     role          = "WRITER"
  #     group_by_email = "${local.unique_id}-ds@gmail.com"
  #   }
  #   access {
  #     role           = "OWNER"
  #     group_by_email = "${local.unique_id}-de@gmail.com"
  #   }
  #   access {
  #     role           = "READER"
  #     group_by_email = "${local.unique_id}-da@gmail.com"
  #   }
}

resource "google_bigquery_dataset" "staging" {
  dataset_id    = format("staging_%s", var.env)
  friendly_name = format("staging_%s", var.env)
  description   = format("Dataset for staging data, flattened and deduped from raw for [%s] env.", var.env)
  project       = var.project_id
  location      = var.region

  labels = {
    env = var.env
  }

  #   access {
  #     role          = "WRITER"
  #     group_by_email = "${local.unique_id}-ds@gmail.com"
  #   }
  #   access {
  #     role           = "OWNER"
  #     group_by_email = "${local.unique_id}-de@gmail.com"
  #   }
  #   access {
  #     role           = "READER"
  #     group_by_email = "${local.unique_id}-da@gmail.com"
  #   }
}

resource "google_bigquery_dataset" "analytics" {
  dataset_id    = format("analytics_%s", var.env)
  friendly_name = format("analytics_%s", var.env)
  description   = format("Analytics database for [%s] env, built off of staging.", var.env)
  project       = var.project_id
  location      = var.region

  labels = {
    env = var.env
  }

  #   access {
  #     role          = "WRITER"
  #     group_by_email = "${local.unique_id}-ds@gmail.com"
  #   }
  #   access {
  #     role           = "OWNER"
  #     group_by_email = "${local.unique_id}-de@gmail.com"
  #   }
  #   access {
  #     role           = "READER"
  #     group_by_email = "${local.unique_id}-da@gmail.com"
  #   }
}

resource "google_bigquery_dataset" "marketing" {
  dataset_id    = format("marketing_%s", var.env)
  friendly_name = format("marketing_%s", var.env)
  description   = format("Marketing database for [%s] env, built off of staging.", var.env)
  project       = var.project_id
  location      = var.region

  labels = {
    env = var.env
  }

  #   access {
  #     role          = "WRITER"
  #     group_by_email = "${local.unique_id}-ds@gmail.com"
  #   }
  #   access {
  #     role           = "OWNER"
  #     group_by_email = "${local.unique_id}-de@gmail.com"
  #   }
  #   access {
  #     role           = "READER"
  #     group_by_email = "${local.unique_id}-da@gmail.com"
  #   }
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
