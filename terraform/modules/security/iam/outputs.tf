output "developer_group_name" {
  description = "Name of the developers IAM group"
  value       = aws_iam_group.developers.name
}

output "operations_group_name" {
  description = "Name of the operations IAM group"
  value       = aws_iam_group.operations.name
}

output "ec2_instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_instance_profile_arn" {
  description = "ARN of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.arn
}

output "ec2_role_name" {
  description = "Name of the EC2 IAM role"
  value       = aws_iam_role.ec2_role.name
}