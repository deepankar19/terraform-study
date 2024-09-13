#Create Vpc

resource "aws_vpc" "nginx_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "nginx_vpc"
  }
}

#Private Subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.nginx_vpc.id
  tags = {
    Name = "private-subnet"
  }
}

#Public Subnet
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.nginx_vpc.id
  tags = {
    Name = "public-subnet"
  }
}

#Internet gateway
resource "aws_internet_gateway" "nginx-igw" {
  vpc_id = aws_vpc.nginx_vpc.id
  tags = {
    Name = "nginx-igw"
  }
}

#Routing table
resource "aws_route_table" "nginx-rt" {
  vpc_id = aws_vpc.nginx_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nginx-igw.id
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.nginx-rt.id
  subnet_id      = aws_subnet.public-subnet.id
}