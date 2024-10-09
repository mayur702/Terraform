terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region = "us-east-2"

}
resource "random_id" "rand_id" {
    byte_length = 5
  
}
resource "aws_s3_bucket" "demo-bucket" {
  bucket = "mayur-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.demo-bucket.bucket
    source = "./myfile.txt"
    key = "mydata.txt"
  
}
output "name" {
    value = random_id.rand_id.hex
  
}