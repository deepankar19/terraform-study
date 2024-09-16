terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  project = "xxxx-Res-91524"
}

variable "aws_ami_image" {
  type        = string
  description = "amazom linux 2023"
  default     = "ami-0e53db6fd757e38c7"
}

variable "aws_instance_type" {
  type        = string
  description = "ec2 family instance of type "
  default     = "t2.micro"
}

resource "aws_vpc" "multi-az-vpc" {
  cidr_block = "11.0.0.0/16"
  tags = {
    Name    = "${local.project}-vpc-mumbai"
    ENV     = "PROD"
    project = local.project
  }
}

resource "aws_subnet" "multi-subnet" {
  vpc_id     = aws_vpc.multi-az-vpc.id
  cidr_block = "11.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name    = "${local.project}-subnet-${count.index}"
    ENV     = "PROD"
    project = local.project
  }
}

#Creating 4ec2 instance 2 in every subnet
resource "aws_instance" "main" {
  ami           = var.aws_ami_image
  instance_type = var.aws_instance_type
  count         = 4
  subnet_id     = element(aws_subnet.multi-subnet[*].id, count.index % length(aws_subnet.multi-subnet))

  #understanding
  # 0%2 = 0
  # 1%2 = 1
  # 2%2 = 0
  # 3%2 = 1

  tags = {
    Name    = "${local.project}-instance-${count.index}"
    ENV     = "PROD"
    project = local.project
  }
}


output "aws_subnet_id" {
  value = aws_subnet.multi-subnet[0].id
}