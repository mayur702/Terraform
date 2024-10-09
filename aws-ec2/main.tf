terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  region = var.region

}
resource "aws_instance" "myserver" {
  ami           = "ami-0ea3c35c5c3284d82"
  instance_type = "t3.micro"
  
  tags = {
    Name = "SampleServer"
  }
}