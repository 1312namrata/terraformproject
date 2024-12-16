terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.1"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}
resource "aws_vpc" "myvpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "publicsubnet"
  }
}
resource "aws_subnet" "privatesubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "privatesubnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "igw"
  }

}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags ={
    name = "second route table"
  }
  
}

resource "aws_route_table_association" "publicsubnet" {
  subnet_id      = "subnet-09efc01d5da3db235"
  route_table_id = "rtb-049e1d64b972c602c"
}

resource "aws_route_table_association" "privatesubnet" {
  subnet_id     = "subnet-082aa618ffc04c5f5"
  route_table_id = "rtb-0f5427e02536e87bb"
}
