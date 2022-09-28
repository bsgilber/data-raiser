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

variable "dataset_id" {
  type        = string
  description = "id for the dataset (database) that this table should live in"
}

variable "schema_filepath" {
  type        = string
  description = "location of the json schema file"
}

variable "time_partitioning_type" {
  type        = string
  description = "The supported types are DAY, HOUR, MONTH, and YEAR, which will generate one partition per day, hour, month, and year, respectively."
  default     = "DAY"
}

variable "table_name" {
  type        = string
  description = "A unique ID for the resource, this will double as the friendly name."
}
