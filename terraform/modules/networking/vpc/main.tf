# VPC Module for AWS Infrastructure Foundations

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.prefix}-igw"
  }
}

# Create public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index % length(var.availability_zones)]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.prefix}-public-subnet-${count.index + 1}"
    Tier = "Public"
  }
}

# Create private application subnets
resource "aws_subnet" "private_app" {
  count             = length(var.app_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  
  tags = {
    Name = "${var.prefix}-private-app-subnet-${count.index + 1}"
    Tier = "Application"
  }
}

# Create private database subnets
resource "aws_subnet" "private_db" {
  count             = length(var.db_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
  
  tags = {
    Name = "${var.prefix}-private-db-subnet-${count.index + 1}"
    Tier = "Database"
  }
}

# Create Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  count  = var.single_nat_gateway ? 1 : length(var.public_subnet_cidrs)
  domain = "vpc"
  
  tags = {
    Name = "${var.prefix}-nat-eip-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.main]
}

# Create NAT Gateways
resource "aws_nat_gateway" "main" {
  count         = var.single_nat_gateway ? 1 : length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  
  tags = {
    Name = "${var.prefix}-nat-gateway-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.main]
}

# Create route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = {
    Name = "${var.prefix}-public-rt"
  }
}

# Create route tables for private subnets
resource "aws_route_table" "private" {
  count  = var.single_nat_gateway ? 1 : length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.single_nat_gateway ? aws_nat_gateway.main[0].id : aws_nat_gateway.main[count.index].id
  }
  
  tags = {
    Name = "${var.prefix}-private-rt-${count.index + 1}"
  }
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate private app subnets with private route tables
resource "aws_route_table_association" "private_app" {
  count          = length(var.app_subnet_cidrs)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = var.single_nat_gateway ? aws_route_table.private[0].id : aws_route_table.private[count.index % length(aws_route_table.private)].id
}

# Associate private db subnets with private route tables
resource "aws_route_table_association" "private_db" {
  count          = length(var.db_subnet_cidrs)
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = var.single_nat_gateway ? aws_route_table.private[0].id : aws_route_table.private[count.index % length(aws_route_table.private)].id
}