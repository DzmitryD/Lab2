provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20201026"]
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "dulski-remote-state"
    key    = "dev/Lab2/network/terraform.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "SG" {
  backend = "s3"
  config = {
    bucket = "dulski-remote-state"
    key    = "dev/Lab2/SG/terraform.tfstate"
    region = "us-east-2"
  }
}

terraform {
  backend "s3" {
    bucket = "dulski-remote-state"
    key    = "dev/Lab2/main/terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${data.terraform_remote_state.SG.outputs.security_group}"]
  subnet_id              = data.terraform_remote_state.network.outputs.Lab2_public_subnet_ids[0]
  key_name               = var.key
  tags = {
    Name = "${var.env}-WebServer"
  }
}

