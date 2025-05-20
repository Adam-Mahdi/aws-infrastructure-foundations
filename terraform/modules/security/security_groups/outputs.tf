output "bastion_sg_id" {
  description = "ID of the bastion hosts security group"
  value       = aws_security_group.bastion.id
}

output "web_sg_id" {
  description = "ID of the web tier security group"
  value       = aws_security_group.web.id
}

output "app_sg_id" {
  description = "ID of the application tier security group"
  value       = aws_security_group.app.id
}

output "db_sg_id" {
  description = "ID of the database tier security group"
  value       = aws_security_group.db.id
}

output "alb_sg_id" {
  description = "ID of the application load balancer security group"
  value       = aws_security_group.alb.id
}