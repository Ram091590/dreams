terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.2.3"
  backend "s3" {
    bucket = "dreams-bucket-tf"
    key    = "dreams"
    region = "us-east-1"
  }

}
provider "aws" {
  region = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID      
  secret_key = var.AWS_SECRET_ACCESS_KEY_ID
}

