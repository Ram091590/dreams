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
}
