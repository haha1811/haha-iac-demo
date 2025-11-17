resource "aws_instance" "ftp_prod" {
  ami                    = var.ami_ubuntu-2404_id
  instance_type          = "t3.micro"
  
  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true  # 加密幾乎不會慢;PCI / ISO 27001 / HIPAA / 金融業均要求加密。
    
    tags = {
      Name = "ftp-prod-root-volume"
      Purpose = "system-disk"
    }
    
  }
  
  subnet_id              = var.public_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.ap_sg_id]
  tags = {
    Name = "${var.project}-ftp-prod"
  }
}

 resource "aws_instance" "ftp_uat" {
  ami                    = var.ami_ubuntu-2404_id
  instance_type          = "t3.micro"
  
  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true  # 加密幾乎不會慢;PCI / ISO 27001 / HIPAA / 金融業均要求加密。
    
    tags = {
      Name = "ftp-uat-root-volume"
      Purpose = "system-disk"
    }
  }
  
  subnet_id              = var.public_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.ap_sg_id]
  tags = {
    Name = "${var.project}-ftp-uat"
  }
}


#resource "aws_ebs_volume" "data_100_prod" {
#  availability_zone = aws_instance.ftp_prod.availability_zone
#  size              = 100
#  type              = "gp3"
#  encrypted         = true  # 加密幾乎不會慢;PCI / ISO 27001 / HIPAA / 金融業均要求加密。
#  tags = {
#    Name = "${var.project}-data-100-prod"
#  }
#}

#resource "aws_volume_attachment" "data_100_prod_attach" {
#  device_name = "/dev/sdd" # 會映射成新磁碟，之後在磁碟管理初始化
#  volume_id   = aws_ebs_volume.data_100_prod.id
#  instance_id = aws_instance.ftp_prod.id
#}

#resource "aws_ebs_volume" "data_100_uat" {
#  availability_zone = aws_instance.ftp_uat.availability_zone
#  size              = 100
#  type              = "gp3"
#  encrypted         = true  # 加密幾乎不會慢;PCI / ISO 27001 / HIPAA / 金融業均要求加密。
#  tags = {
#    Name = "${var.project}-data-100-uat"
#  }
#}

#resource "aws_volume_attachment" "data_100_uat_attach" {
#  device_name = "/dev/sdd" # 會映射成新磁碟，之後在磁碟管理初始化
#  volume_id   = aws_ebs_volume.data_100_uat.id
#  instance_id = aws_instance.ftp_uat.id
#}





# ----- output -----

output "ftp_prod_instance_id" {
  value = aws_instance.ftp_prod.id
}

output "ftp_uat_instance_id" {
  value = aws_instance.ftp_uat.id
}

