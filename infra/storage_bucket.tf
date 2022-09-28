module "landing_data_bucket_creation" {
  source = "./modules/landing_bucket"

  env            = "DEV"
  project_id     = "gilbert-learning-gcp-113"
  payload_format = "JSON_API_V1"
}
