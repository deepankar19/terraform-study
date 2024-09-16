provider "aws" {
  region = "ap-south-1"
}


module "vpc" {
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-test-vpc"
  }

}