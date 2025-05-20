terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # This will be uncommented when we set up the S3 backend
  # backend "s3" {
  #   bucket         = "aws-infrastructure-terraform-state"
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-state-lock"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "aws-infrastructure-foundations"
      ManagedBy   = "terraform"
    }
  }
}

# Variables used in this configuration
variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}