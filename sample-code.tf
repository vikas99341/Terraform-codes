provider "aws"{
region = "us-east-1"
}

# 1. Create a vpc
resource "aws_vpc" "edu-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
  Name = "edureka"
}
}

# 2. Create Internet gateway
resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.edu-vpc.id
 }

 # 3. Create custome route table

resource "aws_route_table" "edu-route-table" {
vpc_id = aws_vpc.edu-vpc.id
route {
cidr_block = "0.0.0.0/0"
# this means all traffic is allowed
     gateway_id = aws_internet_gateway.gw.id
   }
   route {
     ipv6_cidr_block = "::/0"
     gateway_id      = aws_internet_gateway.gw.id
}
 tags = {
     Name = "edureka"
   }
 }

 # 4. Create subnet where our webserver is going to reside on_failure
 resource "aws_subnet" "subnet-1" {
   vpc_id            = aws_vpc.edu-vpc.id
   cidr_block        = "10.0.1.0/24"
   availability_zone = "us-east-1a"

   tags = {
     Name = "edu-subnet"
   }
 }
# 5. Associate route table to subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.edu-route-table.id
}
# 6. Create a security group
resource "aws_security_group" "allow_web" {
   name        = "allow_web_traffic"
   description = "Allow Web inbound traffic"
     vpc_id      = aws_vpc.edu-vpc.id
ingress {
     description = "HTTPS"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
}
ingress {
     description = "HTTP"
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
     description = "SSH"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
     Name = "allow_web"
   }
 }

 # 7. Create a network_interface

 resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
   security_groups = [aws_security_group.allow_web.id]
}

# 8. Create elastic_ip
resource "aws_eip" "one" {
   vpc                       = true
   network_interface         = aws_network_interface.web-server-nic.id
   associate_with_private_ip = "10.0.1.50"
   depends_on                = [aws_internet_gateway.gw]
 }

# 9. Create aws_instance

resource "aws_instance" "web-server-instance1" {
   ami               = "ami-0747bdcabd34c712a"
   instance_type     = "t2.micro"
   availability_zone = "us-east-1a"
   key_name          = "mykey13march"
depends_on                = [aws_eip.one]
   network_interface {
     device_index         = 0
     network_interface_id = aws_network_interface.web-server-nic.id
   }

   user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 sudo apt install apache2 -y
                 sudo systemctl start apache2
                 sudo bash -c 'echo Learning Terraform on AWS !! > /var/www/html/index.html'
                 EOF
   tags = {
     Name = "web-server"
   }
 }
