// create the landing bucket
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "landing_bucket" {
  name          = format("${random_id.bucket_prefix.hex}-%s-landing-bucket", var.env)
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  project       = var.project_id
  versioning {
    enabled = false
  }
}

resource "google_pubsub_topic" "topic" {
  name = format("%s-landing-bucket-topic", var.env)
}

// gcs topic owner account
resource "google_service_account" "gcs_topic_owner" {
  account_id   = format("svc-gcs-topic-owner-%s", lower(var.env))
  display_name = "Connection Hub Service Account"

  project = var.project_id
}

// IAM permissions
resource "google_pubsub_topic_iam_binding" "binding" {
  topic = google_pubsub_topic.topic.id
  role  = "roles/pubsub.publisher"
  members = [
    format("serviceAccount:%s", google_service_account.gcs_topic_owner.email)
  ]
}

// and turn notifications on
resource "google_storage_notification" "notification" {
  bucket         = google_storage_bucket.landing_bucket.name
  payload_format = var.payload_format
  topic          = google_pubsub_topic.topic.id

  depends_on = [google_pubsub_topic_iam_binding.binding]
}
