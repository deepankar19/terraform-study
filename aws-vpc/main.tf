#Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

# Private Subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  tags = {
    Name = "private-subnet"
  }
}

# Public Subnet
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  tags = {
    Name = "public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

#Route table
resource "aws_route_table" "my-rtl" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "my-rtl"
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-rtl.id
  subnet_id      = aws_subnet.public-subnet.id
}

resource "aws_instance" "web" {
  ami           = var.ami-image
  instance_type = var.instance-type
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "Demo Ec2 instance"
  }
}