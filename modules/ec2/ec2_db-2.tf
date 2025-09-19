resource "aws_instance" "db_2" {
  ami                    = var.ami_windows-2025_id
  instance_type          = "t3.medium"
  subnet_id              = var.private_subnet_2_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.db_sg_id]
  tags = {
    Name = "${var.project}-db-2"
  }
}


# ----- output -----

output "db_2_instance_id" {
  value = aws_instance.db_2.id
}

output "db_2_availability_zone" {
  value = aws_instance.db_2.availability_zone
}

