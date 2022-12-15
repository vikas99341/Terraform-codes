# Code for learning terraform
/* new code written
  for terraform on aws */

provider "aws" {
  region = var.region
}

resource "aws_instance" "myec2" {
  ami           = lookup(var.ami,var.region)
  instance_type = var.instancetype
  count = 2

  tags = {
     Name = element(var.tags,count.index)
   }
}
