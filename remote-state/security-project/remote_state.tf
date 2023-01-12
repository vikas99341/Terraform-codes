data "terraform_remote_state" "eip" {
  backend = "s3"
  config = {
    bucket = "terraform-eve-s3-backend-1101"
    key    = "network-project/eip.tfstate"
    region = "ap-south-1"
  }
}
