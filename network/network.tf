provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "dulski-remote-state"
    key    = "dev/Lab2/network/terraform.tfstate"
    region = "us-east-2"
  }
}

module "vpc-Lab2" {
  // source = "../modules/aws_network"
  source               = "git@github.com:DzmitryD/terraform-modules.git//aws_network"
  env                  = "Lab2"
  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidrs  = ["10.100.1.0/24"]
  private_subnet_cidrs = []
}

