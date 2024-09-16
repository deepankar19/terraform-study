output "aws_ami" {
  value = data.aws_ami.data_ami_image
}

output "aws_zones" {
  value = data.aws_availability_zones.names
}

#To get the account details
data "aws_caller_identity" "name" {
}
data "aws_region" "name" {
}

output "caller_info" {
  value = data.aws_caller_identity.name
}

output "region_name" {
  value = data.aws_region.name
}

output "security_group" {
  value = data.aws_security_group.data_sgrp.id
}
output "vpc_id" {
  value = data.aws_vpc.name.id
}