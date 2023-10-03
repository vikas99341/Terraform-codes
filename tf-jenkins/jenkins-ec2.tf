resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = "terraform"
  iam_instance_profile   = "${aws_iam_instance_profile.ec2_profile.name}"
  vpc_security_group_ids = [aws_security_group.allow_login.id]
  tags = {
    Name = var.project
    OS = "ubuntu"
  }
  user_data = <<-EOF
#!/bin/bash

sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo yum install python-pip -y
sudo pip install ansible
sudo pip install boto3
EOF
}
