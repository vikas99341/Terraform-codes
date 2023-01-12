terraform {
  backend "s3" {
    bucket = "terraform-eve-s3-backend-1101"
    key    = "network-project/eip.tfstate"
    region = "ap-south-1"
  }
}
