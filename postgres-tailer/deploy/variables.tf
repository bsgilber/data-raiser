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

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "image" {
  type    = string
  default = "debian-10-buster-v20220920"
}

variable "cos_image_name" {
  description = "The forced COS image to use instead of latest"
  default     = "cos-stable-77-12371-89-0"
}

variable "env" {
  type    = string
  default = "dev"
}
