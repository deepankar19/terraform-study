terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}