variable "region" {
  description = "AWS Region where to provision VPC Network"
  default     = "us-east-2"
}
variable "Allow_ports_in" {
  type    = list(string)
  default = ["0"]
}

variable "Allow_ports_out" {
  type    = list(string)
  default = ["0"]
}

variable "Protocol_in" {
  default = "-1"
}

variable "Protocol_out" {
  default = "-1"
}

variable "CidrBlock_in" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "CidrBlock_out" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "tags_common" {
  default = "dev"
}

