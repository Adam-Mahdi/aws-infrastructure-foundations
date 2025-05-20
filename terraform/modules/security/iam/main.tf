# IAM Module for AWS Infrastructure Foundations

# Create an IAM group for developers
resource "aws_iam_group" "developers" {
  name = "${var.prefix}-developers"
}

# Create an IAM group for operations
resource "aws_iam_group" "operations" {
  name = "${var.prefix}-operations"
}

# Create an IAM policy for read-only access to specific resources
resource "aws_iam_policy" "read_only_access" {
  name        = "${var.prefix}-read-only-access"
  description = "Provides read-only access to specific AWS resources"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "s3:List*",
          "s3:Get*",
          "cloudwatch:Get*",
          "cloudwatch:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Create a policy for EC2 instance management
resource "aws_iam_policy" "ec2_management" {
  name        = "${var.prefix}-ec2-management"
  description = "Provides permissions to manage EC2 instances"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:Start*",
          "ec2:Stop*",
          "ec2:Reboot*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach policies to groups
resource "aws_iam_group_policy_attachment" "developers_read_only" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.read_only_access.arn
}

resource "aws_iam_group_policy_attachment" "operations_ec2" {
  group      = aws_iam_group.operations.name
  policy_arn = aws_iam_policy.ec2_management.arn
}

# Create IAM role for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name = "${var.prefix}-ec2-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Create instance profile for EC2 instances
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.prefix}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# Attach S3 read-only access policy to EC2 role
resource "aws_iam_role_policy" "s3_read_access" {
  name = "${var.prefix}-s3-read-access"
  role = aws_iam_role.ec2_role.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Get*",
          "s3:List*"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.app_bucket_name}",
          "arn:aws:s3:::${var.app_bucket_name}/*"
        ]
      }
    ]
  })
}