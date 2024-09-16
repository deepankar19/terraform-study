resource "aws_instance" "web" {
  ami           = var.ami-image
  instance_type = var.instance-type

  tags = {
    Name = "Demo Ec2 instance"
  }
}