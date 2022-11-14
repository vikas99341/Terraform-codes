main.tf:
=======

provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = var.instancetype
}

variables.tf:
=============

variable "instancetype" {
  default = "t2.micro"
}

===================
terraform plan -var="instancetype=t2.small"

=================
create terraform.tfvars 
instancetype="t2.large"

but if you give a different name the please use the below command : terraform plan -var-file="custom.tfvar"

Environment Variables:
export TF_VAR_instancetype="t2.nano"
echo $TF_VAR
setx TF_VAR_instancetype t2.large
