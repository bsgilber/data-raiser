variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
  default     = "gilbert-learning-gcp-113"
}

variable "env" {
  type        = string
  description = "Environment name [DEV, STAGE, PROD]"
  default     = "DEV"
}
