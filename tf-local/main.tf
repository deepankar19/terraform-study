locals {
  owner = "Amazon spacelift"
  name  = "Spacelift-1524-xe-487"
}

resource "aws_instance" "web" {
  ami           = var.ami-image
  instance_type = var.aws-instance-type

  tags = {
    Name    = "Demo Ec2 instance"
    Project = local.name
  }
}