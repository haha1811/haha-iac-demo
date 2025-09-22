resource "aws_instance" "sqlserveralwayson" {
  ami                    = var.ami_windows-2025_id
  instance_type          = "t3.medium"
  subnet_id              = var.private_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.ap_sg_id]
  tags = {
    Name = "${var.project}-SqlServerAlwaysOn"
  }
}


# ----- output -----

output "sqlserveralwayson_instance_id" {
  value = aws_instance.sqlserveralwayson.id
}

output "sqlserveralwayson_availability_zone" {
  value = aws_instance.sqlserveralwayson.availability_zone
}