provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "dulski-remote-state"
    key    = "dev/Lab2/SG/terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_security_group" "web" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = var.Allow_ports_in
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.Protocol_in
      cidr_blocks = var.CidrBlock_in
    }
  }
  dynamic "egress" {
    for_each = var.Allow_ports_out
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = var.Protocol_out
      cidr_blocks = var.CidrBlock_out
    }
  }
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  tags = {
    Name = "${var.tags_common}-security"
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
