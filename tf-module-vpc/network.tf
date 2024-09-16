
provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Name
variable "name" {
  description = "VPC Name"
  type        = string
  default     = "vpc-terraform"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "prod"
}
# Business Division
variable "owners" {
  description = "organization this Infrastructure belongs"
  type        = string
  default     = "aws"
}

# Local Values in Terraform
locals {
  owners      = var.owners
  environment = var.environment
  name        = "${local.owners}-${local.environment}"
  tags = {
    owners      = local.owners
    environment = local.environment
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  azs  = data.aws_availability_zones.available.names
  name = "${var.name}-${local.name}"
  cidr = "11.0.0.0/16"

  private_subnets = ["11.0.1.0/24"]
  public_subnets  = ["11.0.0.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    name = "test-vpc-module"
    Terraform   = "true"
    Environment = "dev"
  }
}


