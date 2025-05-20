# Security Groups Module for AWS Infrastructure Foundations

# Bastion host security group
resource "aws_security_group" "bastion" {
  name        = "${var.prefix}-bastion-sg"
  description = "Security group for bastion hosts"
  vpc_id      = var.vpc_id
  
  # SSH access from specific IP ranges
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_allowed_cidr
    description = "SSH access from allowed IP ranges"
  }
  
  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name = "${var.prefix}-bastion-sg"
  }
}

# Web tier security group
resource "aws_security_group" "web" {
  name        = "${var.prefix}-web-sg"
  description = "Security group for web tier"
  vpc_id      = var.vpc_id
  
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access from anywhere"
  }
  
  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access from anywhere"
  }
  
  # SSH access from bastion hosts
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
    description     = "SSH access from bastion hosts"
  }
  
  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name = "${var.prefix}-web-sg"
  }
}

# Application tier security group
resource "aws_security_group" "app" {
  name        = "${var.prefix}-app-sg"
  description = "Security group for application tier"
  vpc_id      = var.vpc_id
  
  # Application port access from web tier
  ingress {
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
    description     = "Application access from web tier"
  }
  
  # SSH access from bastion hosts
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
    description     = "SSH access from bastion hosts"
  }
  
  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name = "${var.prefix}-app-sg"
  }
}

# Database tier security group
resource "aws_security_group" "db" {
  name        = "${var.prefix}-db-sg"
  description = "Security group for database tier"
  vpc_id      = var.vpc_id
  
  # Database port access from application tier
  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
    description     = "Database access from application tier"
  }
  
  # Outbound internet access for updates
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name = "${var.prefix}-db-sg"
  }
}

# Load balancer security group
resource "aws_security_group" "alb" {
  name        = "${var.prefix}-alb-sg"
  description = "Security group for application load balancer"
  vpc_id      = var.vpc_id
  
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access from anywhere"
  }
  
  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access from anywhere"
  }
  
  # Outbound access to web instances
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name = "${var.prefix}-alb-sg"
  }
}