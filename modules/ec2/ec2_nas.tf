resource "aws_instance" "nas" {
  ami                    = var.ami_windows-2025_id
  instance_type          = "t3.medium"
  subnet_id              = var.private_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.db_sg_id]
  tags = {
    Name = "${var.project}-nas"
  }
}


# ----- output -----

output "nas_instance_id" {
  value = aws_instance.nas.id
}

output "nas_availability_zone" {
  value = aws_instance.nas.availability_zone
}