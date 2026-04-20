# [AWS] Modular VPC for Enterprise Landing Zone
# This module implements the "Golden Path" for networking.

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The vpc_cidr must be a valid CIDR block."
  }
}

variable "environment" {
  description = "Deployment environment (e.g. prod, staging)"
  type        = string
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "massdriver-vpc-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Aegis-IaC-Orchestrator"
  }
}

# Private Subnet (No direct internet access)
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-${var.environment}"
    Tier = "Private"
  }
}

# Public Subnet (For load balancers/gateways)
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 100)
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-${var.environment}"
    Tier = "Public"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}
