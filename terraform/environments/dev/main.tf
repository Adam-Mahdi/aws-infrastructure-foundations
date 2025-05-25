# Development Environment Configuration

# Include shared provider configuration
include {
  path = "../../shared/provider.tf"
}

# Local variables
locals {
  prefix        = "awsinfra-dev"
  region        = "us-east-1"
  environment   = "dev"
  instance_type = "t2.micro"  # Free tier eligible
}

# VPC Module
module "vpc" {
  source = "../../modules/networking/vpc"
  
  prefix              = local.prefix
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  app_subnet_cidrs    = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidrs     = ["10.0.5.0/24", "10.0.6.0/24"]
  availability_zones  = ["${local.region}a", "${local.region}b"]
  single_nat_gateway  = true  # Use single NAT gateway for cost savings in dev
}

# Security Groups Module
module "security_groups" {
  source = "../../modules/security/security_groups"
  
  prefix     = local.prefix
  vpc_id     = module.vpc.vpc_id
  app_port   = 8080
  db_port    = 5432
  
  # Use your own IP for secure SSH access - this is just a placeholder
  bastion_allowed_cidr = ["0.0.0.0/0"]  # TODO: Replace with your IP
}

# IAM Module
module "iam" {
  source = "../../modules/security/iam"
  
  prefix          = local.prefix
  app_bucket_name = "${local.prefix}-app-assets"
}

# S3 Storage Module
module "s3" {
  source      = "../../modules/storage/s3"
  bucket_name = "${local.prefix}-app-assets"
}

# Compute Module
module "compute" {
  source = "../../modules/compute"
  
  prefix                     = local.prefix
  vpc_id                     = module.vpc.vpc_id
  public_subnet_ids          = module.vpc.public_subnet_ids
  alb_security_group_id      = module.security_groups.alb_sg_id
  web_security_group_id      = module.security_groups.web_sg_id
  bastion_security_group_id  = module.security_groups.bastion_sg_id
  instance_profile_name      = module.iam.ec2_instance_profile_name
  key_pair_name             = "adam-keypair" # You'll need to create this
}


# Outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "bastion_sg_id" {
  value = module.security_groups.bastion_sg_id
}

output "ec2_instance_profile_name" {
  value = module.iam.ec2_instance_profile_name
}

output "load_balancer_dns" {
  value = module.compute.load_balancer_dns
}

output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}
