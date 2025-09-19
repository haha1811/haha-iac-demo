# DB-1 100GB gp3
resource "aws_ebs_volume" "db_1_data_100" {
  availability_zone = var.db_1_availability_zone
  size              = 100
  type              = "gp3"
  tags = {
    Name = "${var.project}-db-1-data-100"
  }
}

resource "aws_volume_attachment" "db_1_data_100_attach" {
  device_name = "/dev/sdd" # Windows 會映射成新磁碟，之後在磁碟管理初始化
  volume_id   = aws_ebs_volume.db_1_data_100.id
  instance_id = var.db_1_instance_id
}


# DB-2 100GB gp3
resource "aws_ebs_volume" "db_2_data_100" {
  availability_zone = var.db_2_availability_zone
  size              = 100
  type              = "gp3"
  tags = {
    Name = "${var.project}-db-2-data-100"
  }
}

resource "aws_volume_attachment" "db_2_data_100_attach" {
  device_name = "/dev/sdd" # Windows 會映射成新磁碟，之後在磁碟管理初始化
  volume_id   = aws_ebs_volume.db_2_data_100.id
  instance_id = var.db_2_instance_id
}


# NAS 100GB gp3
resource "aws_ebs_volume" "nas_data_100" {
  availability_zone = var.nas_availability_zone
  size              = 100
  type              = "gp3"
  tags = {
    Name = "${var.project}-nas-data-100"
  }
}

resource "aws_volume_attachment" "nas_data_100_attach" {
  device_name = "/dev/sdb" # Windows 會映射成新磁碟，之後在磁碟管理初始化
  volume_id   = aws_ebs_volume.nas_data_100.id
  instance_id = var.nas_instance_id
}


# ----- output -----

output "db_1_data_100_volume_id" { value = aws_ebs_volume.db_1_data_100.id }

output "db_2_data_100_volume_id" { value = aws_ebs_volume.db_2_data_100.id }

output "nas_data_100_volume_id" { value = aws_ebs_volume.nas_data_100.id }

