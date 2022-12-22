provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0cca134ec43cf708f"
   instance_type = "t2.micro"
   count = 3
}

output "aws_instance"{
   value = aws_instance.myec2[*].id
}
