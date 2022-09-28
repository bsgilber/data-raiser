module "landing_table_creation_alpha" {
  source                 = "./modules/landing"

  project_id             = "gilbert-learning-gcp-113"
  env                    = "DEV"
  dataset_id             = google_bigquery_dataset.analytics.dataset_id
  schema_filepath        = "somepath"
  time_partitioning_type = "DAY"
  table_name             = "alpha_table"
}
