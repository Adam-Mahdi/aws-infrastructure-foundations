# Contributing Guide

Thank you for considering contributing to this project. This document outlines the process for contributing changes.

## Prerequisites

- AWS account and appropriate IAM permissions
- Terraform v1.0.0 or newer
- Git
- Basic understanding of AWS services and Terraform

## Getting Started

1. Fork this repository
2. Clone your fork locally:
   ```
   git clone https://github.com/yourusername/aws-infrastructure-foundations.git
   cd aws-infrastructure-foundations
   ```
3. Create a new branch for your feature:
   ```
   git checkout -b feature/my-new-feature
   ```

## Development Workflow

1. **Follow the Git workflow** as outlined in [GIT_WORKFLOW.md](GIT_WORKFLOW.md)
2. **Make changes** to the Terraform modules, documentation, or scripts
3. **Test your changes** locally before committing:
   ```
   terraform init
   terraform validate
   terraform plan
   ```
4. **Format your code**:
   ```
   terraform fmt
   ```
5. **Commit your changes** with a clear, descriptive message
6. **Push your branch** to your fork
7. **Create a Pull Request** against the main repository

## Code Standards

### Terraform Style

- Use consistent naming conventions:
  - Resources: `resource_type_name` (e.g., `aws_s3_bucket_logs`)
  - Variables: `descriptive_name` (e.g., `vpc_cidr_block`)
  - Outputs: `resource_attribute` (e.g., `vpc_id`)
- Use 2-space indentation
- Keep resources logically grouped by type
- Use meaningful descriptions for variables and outputs
- Sort resources alphabetically when possible

### Module Structure

Each module should contain:
- `main.tf` - Primary resources
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `README.md` - Module documentation

### Documentation

- Update documentation when changing functionality
- Provide examples in module READMEs
- Use proper Markdown formatting
- Keep architecture diagrams up to date

## Pull Request Process

1. Ensure your code passes all tests and validations
2. Update documentation relevant to the changes
3. Submit a pull request with a clear title and description
4. Respond to feedback and make requested changes
5. Once approved, maintainers will merge your changes

## Security Considerations

- Never commit AWS credentials or secrets
- Follow the principle of least privilege for IAM roles
- Ensure sensitive resources are properly protected
- Encryption should be enabled for data at rest and in transit

## Additional Resources

- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)