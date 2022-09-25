variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
  default     = "gilbert-learning-gcp-113"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "image" {
  type    = string
  default = "debian-10-buster-v20220920"
}

variable "bootstrap_script" {
  type    = string
  default = "./scripts/bootstrap.sh"
}

variable "airflow_image" {
  type    = string
  default = "composer-2.0.27-airflow-2.2.5"
}
