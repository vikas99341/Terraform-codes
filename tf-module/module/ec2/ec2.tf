resource "aws_instance" "myec2" {
   ami = "ami-0cca134ec43cf708f"
   instance_type = var.instance_type
}
