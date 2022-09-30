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

variable "env" {
  type    = string
  default = "dev"
}
