resource "aws_instance" "manual-instane" {
  ami           = "ami-0cca134ec43cf708f"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-08432cbf9355846a1"]
  key_name = "devops-2023"
  tags = {
    Name = "terraform-instane"
  }
}

terraform import aws_instance.manual-instane i-06c6fde87d1457a37
