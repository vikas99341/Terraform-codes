provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0cca134ec43cf708f"
   instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.lb.id
}
