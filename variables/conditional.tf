provider "aws" {
  region     = "us-east-1"
}

variable "istest" {}

resource "aws_instance" "dev" {
   ami = "ami-0b0dcb5067f052a63"
   instance_type = "t2.micro"
   count = var.istest == true ? 3 : 0
}

resource "aws_instance" "prod" {
   ami = "ami-08e637cea2f053dfa"
   instance_type = "t2.large"
   count = var.istest == false ? 1 : 0
}


terraform.tfvars
istest = false
