# 1) DB Subnet Group：放在 VPC 的 private subnets 裡
resource "aws_db_subnet_group" "aurora" {
  name       = "${var.project}-aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name    = "${var.project}-aurora-subnet-group"
    Project = var.project
  }
}
