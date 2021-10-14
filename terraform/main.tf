provider "aws" {
  region = var.primary_region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "defcon-2021-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "defcon-2021-terraform-running-locks"
    encrypt        = true
  }
}