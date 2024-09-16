resource "random_id" "random" {
 byte_length = 8
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "${var.bucket_prefix}-${random_id.random.hex}"

  tags = {
    Name        = "${var.bucket_prefix}-${random_id.random.hex}"
    Environment = "Dev"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami-image
  instance_type = var.instance-type

  tags = {
    Name = "Demo Ec2 instance"
  }
}


# Configure backend using the dynamic bucket name
terraform {
  backend "s3" {
    bucket = "${var.bucket_prefix}-${random_id.random.hex}"
    key    = "backend.tfstate"
    region = "ap-south-1"
  }
}