resource "aws_db_instance" "db_sample" {
  allocated_storage = 50
  identifier = "sampleinstance"
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7.37"
  instance_class = "db.t3.micro"
  name = "db_sample"
  username = "dbadmin"
  password = "${file("../rds_pass.txt")}"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = "true"
}
