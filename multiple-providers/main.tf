provider "aws" {
  region = "ap-south-1"
}

provider "azure" {
  alias = "dummy-name"
  region = "us-east-1"
}

resource "aws_eip" "my-eip-mumbai" {
    vpc = true  
}

resource "aws_eip" "my-eip-n-virginia" {
    vpc = true  
    provider = azure.dummy-name
}
