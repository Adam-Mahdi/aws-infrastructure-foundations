variable "prefix" {
  description = "Prefix to be used for all resources"
  type        = string
  default     = "awsinfra"
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "bastion_allowed_cidr" {
  description = "List of CIDR blocks allowed to connect to bastion hosts"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Should be restricted in production
}

variable "app_port" {
  description = "Port on which the application tier listens"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Port on which the database tier listens"
  type        = number
  default     = 5432  # Default PostgreSQL port
}