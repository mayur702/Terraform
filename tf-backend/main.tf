terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
  backend "s3" {
    bucket = "mayur-aee7ab8ace"
    key = "backend.tfstate"
    region = "us-east-2"
    
  }
}

provider "aws" {
  region = "us-east-2"

}
resource "aws_instance" "myserver" {
  ami           = "ami-0ea3c35c5c3284d82"
  instance_type = "t3.micro"
  
  tags = {
    Name = "SampleServer"
  }
}