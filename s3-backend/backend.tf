terraform {
  backend "s3" {
    bucket = "terraform-eve-s3-backend-1101"
    key    = "ec2/eip.tf"
    region = "ap-south-1"
    dynamodb_table = "morning-lock-table"
  }
}
