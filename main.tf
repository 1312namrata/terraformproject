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
  default_tags {
    tags = {
      Environment = "Production"
      Owner       = "Ops"
    }
  }
  
}


variable "istest" {}

resource "aws_vpc" "my_vpc_test"{
    cidr_block = "10.10.0.0/16"
    count = var.istest == true  ?   1   :   0
    tags =  {
        name = "Dev-vpc"
    } 
}
resource "aws_vpc" "my_vpc_prod" {
    cidr_block = "20.20.0.0/16"
    count = var.istest  ==  false   ?   1   :   0  
     tags =  {
        name = "Dev-vpc"
    }  
    
}

