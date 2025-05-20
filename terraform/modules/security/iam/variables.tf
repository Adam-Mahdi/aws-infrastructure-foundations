variable "prefix" {
  description = "Prefix to be used for all resources"
  type        = string
  default     = "awsinfra"
}

variable "app_bucket_name" {
  description = "Name of the S3 bucket for application assets"
  type        = string
  default     = "app-assets-bucket"
}