Data Types in Terraform:
1. string
2. number
3. bool
4. List(type) == [1,2,3,4] -> List with unique values is called tuple
5. Set(type) == order is not maintained and has unique values only 
6. Map(type) == {"Key": "value"} 
7. Object({<ATTR Name>=<Type>,..})



main.tf
=======
variable "myvar"{
    type= "string"
    default = "my first variable"
}

variable "mymap"{
    type= "map(string)"
    default = {
        my-key: "my first key"
    }
}

variable "mylist"{
    type= list
    default = [1,2,3]
}
terraform console
var.myvar
"${var.myvar}"
var.mymap["my-key"]
var.mylist[0]
element(var.mylist, 0)
slice(var.mylist, 0, 2)

resources.tf
============
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
}

variable "AMIS"{
    type= "map(string)"
    default = {
        us-east-1 = "my ami"
    }
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
}

terraform.tfvars
================
AWS_REGION="us-east-1"
