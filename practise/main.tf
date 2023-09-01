 provider.tf:
 ============
 provider "aws" {
  region = "ap-south-1"
  acess_key = ""
  secret_access_key= ""
}

main.tf:
========
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/24"
# cidr_block       = "${var.vpc_cidr}"  
  instance_tenancy = "default"

  tags = {
    Name = "main"
    Region = "Dev"
  }
}

terraform {
  backend "s3" {
    bucket = "morning-tf-demo-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "morning-tf-demo-table"
  }
}

output "aws_vpc_output" {
  value = "${aws_vpc.main.cidr_block}"
}

==============
variables.tf:
==============
variable "vpc_cidr" {
   description = "Choose your own cidr range"
   type = string
   default = "10.20.0.0/24"
}

Dynamically pass the value While execution :

terraform apply -var "vpc_cidr=172.10.0.0/24"

dev.tfvars:
===========
vpc_cidr = "172.10.0.0/24"

terraform apply -var-file=dev.tfvars

main.tf:
========
locals {
  vpc_name = "${terraform.workspace == "dev" ? "demo-vpc-dev" : "demo-vpc-prod"}"
}
resource "aws_vpc" "main" {
  count            = "${terraform.workspace == "dev" ? 0 : 1}"
  cidr_block       = "${var.cidr_range}"
  instance_tenancy = "default"

  tags = {
    Name = "${local.vpc_name}"
    Environment = "${terraform.workspace}"
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-demo-evening"
    key    = "terraform-backup.tfstate"
    region = "ap-south-1"
    dynamodb_table = "morning-tf-demo-table"
  }
}

