# IAM Module

This module creates the IAM resources needed for our AWS infrastructure.

## Resources Created

- IAM Groups for different user types (developers, operations)
- IAM Policies with least privilege permissions
- IAM Roles for EC2 instances
- IAM Instance Profiles

## Usage

```hcl
module "iam" {
  source = "../../../modules/security/iam"
  
  prefix          = "myproject"
  app_bucket_name = "myproject-app-assets"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| prefix | Prefix to be used for all resources | string | `"awsinfra"` | no |
| app_bucket_name | Name of the S3 bucket for application assets | string | `"app-assets-bucket"` | no |

## Outputs

| Name | Description |
|------|-------------|
| developer_group_name | Name of the developers IAM group |
| operations_group_name | Name of the operations IAM group |
| ec2_instance_profile_name | Name of the EC2 instance profile |
| ec2_instance_profile_arn | ARN of the EC2 instance profile |
| ec2_role_name | Name of the EC2 IAM role |

## Security Considerations

This module follows the principle of least privilege by:

1. Creating separate groups for different user types
2. Granting only the permissions needed for each group
3. Using fine-grained policies for EC2 instances
4. Limiting S3 access to specific buckets