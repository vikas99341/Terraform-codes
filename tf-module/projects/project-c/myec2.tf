module "sgmodule" {
  source = "../../module/sg"
}

resource "aws_instance" "web" {
   ami = "ami-0cca134ec43cf708f"
   instance_type = "t2.micro"
   vpc_security_group_ids = [module.sgmodule.sg_id]
}

output "sg_id_output" {
 value = module.sgmodule.sg_id
}
