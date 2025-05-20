# VPC Module

This module creates a multi-tier VPC architecture designed for hosting scalable, secure applications.

## Architecture

The VPC is designed with a 3-tier architecture:

1. **Public Tier** - Contains load balancers and bastion hosts
2. **Application Tier** - Contains application servers in private subnets
3. **Database Tier** - Contains database servers in isolated private subnets

Each tier is deployed across multiple Availability Zones for high availability.

## Resources Created

- VPC with DNS support enabled
- Internet Gateway for public internet access
- Public subnets across multiple AZs
- Private application subnets across multiple AZs
- Private database subnets across multiple AZs
- NAT Gateways for outbound internet access from private subnets
- Route tables for public and private subnets
- Route table associations

## Usage

```hcl
module "vpc" {
  source = "../../../modules/networking/vpc"
  
  prefix              = "myproject"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  app_subnet_cidrs    = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidrs     = ["10.0.5.0/24", "10.0.6.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
  single_nat_gateway  = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| prefix | Prefix to be used for all resources | string | `"awsinfra"` | no |
| vpc_cidr | CIDR block for the VPC | string | `"10.0.0.0/16"` | no |
| public_subnet_cidrs | CIDR blocks for the public subnets | list(string) | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| app_subnet_cidrs | CIDR blocks for the private application subnets | list(string) | `["10.0.3.0/24", "10.0.4.0/24"]` | no |
| db_subnet_cidrs | CIDR blocks for the private database subnets | list(string) | `["10.0.5.0/24", "10.0.6.0/24"]` | no |
| availability_zones | List of availability zones to use | list(string) | `["us-east-1a", "us-east-1b"]` | no |
| single_nat_gateway | Whether to create a single NAT Gateway for all private subnets | bool | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| vpc_cidr_block | The CIDR block of the VPC |
| public_subnet_ids | List of IDs of public subnets |
| private_app_subnet_ids | List of IDs of private application subnets |
| private_db_subnet_ids | List of IDs of private database subnets |
| nat_gateway_ids | List of IDs of NAT Gateways |
| public_route_table_id | ID of the public route table |
| private_route_table_ids | List of IDs of private route tables |
| internet_gateway_id | ID of the Internet Gateway |

## Network Design Considerations

1. **High Availability**: The design spans multiple Availability Zones to ensure resilience.
2. **Security**: Network traffic is segregated by subnet tier, with private subnets for sensitive resources.
3. **Cost Optimization**: The `single_nat_gateway` variable allows using just one NAT Gateway to reduce costs.
4. **Scalability**: The CIDR ranges allow for future expansion of resources in each tier.