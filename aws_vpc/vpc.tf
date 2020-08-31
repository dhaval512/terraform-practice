#Internet VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "enable"
  enable_dns_hostnames = "enable"


  tags = {
    Name = "main"
  }
}

#subnet

resource "aws_subnet" "main-ap-south-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "main-public-1"
  }
}
resource "aws_subnet" "main-ap-south-1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "main-public-2"
  }
}
resource "aws_subnet" "main-ap-south-1c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "main-public-3"
  }
}
resource "aws_subnet" "main-ap-south-1a-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "main-private-1"
  }
}
resource "aws_subnet" "main-ap-south-1b-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "main-private-2"
  }
}
resource "aws_subnet" "main-ap-south-1c-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "main-private-3"
  }
}

#Internet Getway

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#route Table
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
}
  #route associations public

  resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main-ap-south-1a.id
  route_table_id = aws_route_table.main-public.id
}

 resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.main-ap-south-1b.id
  route_table_id = aws_route_table.main-public.id
}
 resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.main-ap-south-1c.id
  route_table_id = aws_route_table.main-public.id
}