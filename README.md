# AWS Infrastructure Foundations

## Project Overview
This repository contains Terraform code to deploy a secure, scalable multi-tier AWS infrastructure following DevOps and Infrastructure as Code best practices. The architecture demonstrates professional-grade AWS deployment suitable for hosting highly available web applications.

## Architecture
![Architecture Diagram](docs/architecture-diagram.png)

This project implements:
- **Multi-AZ VPC**: Public, private app, and private database subnets
- **Load Balanced Auto-Scaling**: Application Load Balancer with auto-scaling groups
- **Secure Access**: Bastion host architecture with tiered security groups
- **Encrypted Storage**: S3 with versioning, encryption, and lifecycle policies
- **Monitoring & Alerting**: CloudWatch dashboards with CPU alarms
- **Infrastructure as Code**: Complete Terraform modular architecture

## Technologies Used
- **AWS**: Cloud infrastructure provider
- **Terraform**: Infrastructure as Code
- **GitHub**: Version control and collaboration
- **CloudWatch**: Monitoring and alerts

## Repository Structure
```
.
├── terraform/
│   ├── modules/
│   │   ├── networking/     # VPC, subnets, etc.
│   │   ├── compute/        # EC2, ASG, etc.
│   │   ├── security/       # IAM, security groups
│   │   ├── storage/        # S3 buckets
│   │   └── monitoring/     # CloudWatch, SNS
│   ├── environments/
│   │   ├── dev/
│   │   └── prod/
│   └── shared/             # Shared resources
├── docs/
│   └── architecture-diagram.png
├── scripts/
│   └── deploy.sh
├── .gitignore
├── README.md
└── ARCHITECTURE.md
```

## Prerequisites
- AWS Account (Free Tier compatible)
- Terraform v1.0+ installed
- AWS CLI configured with appropriate credentials
- Git

## Deployment Instructions

### Prerequisites
- AWS CLI configured with appropriate credentials
- Terraform v1.0+ installed
- An EC2 Key Pair created (named "adam-keypair" or update in dev/main.tf)

### Quick Start
1. Clone this repository
   ```bash
   git clone https://github.com/yourusername/aws-infrastructure-foundations.git
   cd aws-infrastructure-foundations
   ```

2. Deploy the infrastructure
   ```bash
   cd terraform/environments/dev
   terraform init
   terraform plan
   terraform apply
   ```

3. Access your infrastructure
   - **Load Balancer**: Use the `load_balancer_dns` output
   - **Bastion Host**: SSH to the `bastion_public_ip` output
   - **Monitoring**: Visit the `cloudwatch_dashboard_url` output

4. Clean up (when done)
   ```bash
   terraform destroy
   ```

## Key Features
- **Security**: Defense-in-depth approach with multiple security layers
- **Scalability**: Auto-scaling groups to handle variable loads
- **Resilience**: Multi-AZ deployment for high availability
- **Observability**: Comprehensive monitoring and alerting
- **Cost-Efficiency**: Appropriate instance sizing and auto-scaling

## Security Considerations
- Principle of least privilege for all IAM roles
- No resources directly exposed to the internet except through load balancers
- All data encrypted at rest and in transit
- Network security with security groups and NACLs
- Bastion host for secure administrative access

## Cost Considerations
This architecture is designed to fit within the AWS Free Tier limits during development and testing. Estimated monthly cost for the complete infrastructure outside of Free Tier would be approximately $150-$200 USD.

## Future Enhancements
- Implement AWS WAF for web application security
- Add database tier with RDS
- Integrate with CI/CD pipeline
- Implement infrastructure drift detection

## Contributing
1. Fork the repository
2. Create a feature branch
3. Submit a pull request with a clear description of changes

## License
[MIT License](LICENSE)

## Author
Your Name - [GitHub Profile](https://github.com/yourusername)