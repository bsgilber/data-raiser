module "landing_table_creation_alpha" {
  source = "./modules/landing"

  project_id             = var.project_id
  env                    = var.env
  dataset_id             = google_bigquery_dataset.analytics.dataset_id
  schema                 = file("./schemas/alpha/schema.json")
  time_partitioning_type = "DAY"
  table_name             = "alpha_table"
  prefix_filter          = "data/raw/alpha/"
}
