
data "aws_ami" "data_ami_image" {
  most_recent = true
  owners      = ["amazon"]
}

#security group
data "aws_security_group" "data_sgrp" { 
   tags = {
    name = "MySG"
    ENV  = "PROD"
  }
}

data "aws_vpc" "name" {
  tags = {
    ENV  = "PROD"
    Name = "my-vpc"
  }
}

#AZ 
data "aws_availability_zones" "names" {
  state = "available"
}

#Subnet ID
data "aws_subnet" "name" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    Name = "private-subnet"
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.data_ami_image.id
  instance_type = var.instance-type
  subnet_id = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.data_sgrp.id]
  tags = {
    Name = "SampleServer"
  }
}