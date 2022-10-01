variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
  default     = "gilbert-learning-gcp-113"
}

variable "project_number" {
  type    = string
  default = "133727130486"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "metabase_server_image" {
  type    = string
  default = "us-central1-docker.pkg.dev/gilbert-learning-gcp-113/gilbert-test-repo/metabase:v0.44.4"
}

variable "metabase_cpu" {
  type    = string
  default = "2000m"
}

variable "metabase_mem" {
  type    = string
  default = "2048Mi"
}

variable "metabase_port" {
  type    = string
  default = "3000"
}
variable "repository_id" {
  type    = string
  default = "gilbert-test-repo"
}

variable "tier" {
  type    = string
  default = "db-f1-micro"
}

variable "database_name" {
  type    = string
  default = "metabase_admin"
}

variable "env" {
  type    = string
  default = "dev"
}
