terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"

}
# create a vpc
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc"
    }
  
}

# Private subnet
resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "private-subnet"
    }
}
# Public Subnet
resource "aws_subnet" "Public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "public-subnet"
    }
}
# Internet gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}
# Routing Table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}
resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.Public-subnet.id

}
resource "aws_instance" "myserver" {
  ami           = "ami-0ea3c35c5c3284d82"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.Public-subnet.id
  
  tags = {
    Name = "SampleServer"
  }
}