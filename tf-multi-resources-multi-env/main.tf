terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# locals {
#   project = "xxxx-multi-env-91524"
# }


resource "aws_vpc" "multi-az-vpc" {
  cidr_block = "11.0.0.0/16"
  tags = {
    Name    = "${var.project_name}-vpc-mumbai"
    ENV     = "PROD"
    project = var.project_name
  }
}

resource "aws_subnet" "multi-subnet" {
  vpc_id     = aws_vpc.multi-az-vpc.id
  cidr_block = "11.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name    = "${var.project_name}-subnet-${count.index}"
    ENV     = "PROD"
    project = var.project_name
  }
}

#Creating 4ec2 instance 2 in every subnet
resource "aws_instance" "main" {
  # using for_each & ec2_map
  for_each      = var.ec2_map #we will get each.key & each.value
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = element(aws_subnet.multi-subnet[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.multi-subnet))

  # using count & ec2_config
  # count         = length(var.ec2_config)
  # ami           = var.ec2_config[count.index].ami
  # instance_type = var.ec2_config[count.index].instance_type
  # subnet_id = element(aws_subnet.multi-subnet[*].id, count.index % length(aws_subnet.multi-subnet))

  #understanding
  # 0%2 = 0
  # 1%2 = 1


  tags = {
    Name = "${var.project_name}-instance-${each.key}"
    # Name    = "${var.project_name}-instance-${count.index}"
    ENV     = "PROD"
    project = var.project_name
  }
}


# output "aws_subnet_id" {
#   value = aws_subnet.multi-subnet[length(aws_subnet.multi-subnet)].id
# }