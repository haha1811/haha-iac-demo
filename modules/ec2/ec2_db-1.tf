resource "aws_instance" "db_1" {
  ami                    = var.ami_windows-2025_id
  instance_type          = "t3.medium"
  subnet_id              = var.private_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.db_sg_id]
  tags = {
    Name = "${var.project}-db-1"
  }
}


# ----- output -----

output "db_1_instance_id" {
  value = aws_instance.db_1.id
}

output "db_1_availability_zone" {
  value = aws_instance.db_1.availability_zone
}

