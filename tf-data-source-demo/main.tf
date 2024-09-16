
#security groups
data "aws_security_group" "data-sgp" {
  tags = {
    Name = "Data-source-sgp"
    ENV  = "PROD"
  }
}

#vpc -id
data "aws_vpc" "data-vpc" {
  tags = {
    Name = "my-vpc"
    ENV = "PROD"
  }
}
data "aws_subnet" "data-subnet" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.data-vpc.id]
  }  
  tags = {
    ENV  = "PROD"
    Name = "my-subnet-private1-ap-south-1a"
  }
}

resource "aws_instance" "myserver" {
  ami             = "ami-0e53db6fd757e38c7"
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.data-subnet.id
  security_groups = [data.aws_security_group.data-sgp.id]
  key_name = "heydevops"
  
  tags = {
    Name = "SampleServer"
  }

}


data "aws_caller_identity" "current" {}

