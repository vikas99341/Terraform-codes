resource "aws_instance" "myec2" {
   ami = "ami-0cca134ec43cf708f"
   instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "time_sleep" "wait_70_sec" {
  create_duration = "70s"
}
