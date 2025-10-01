resource "aws_instance" "webserver_1" {
  ami                    = var.ami_ubuntu-2404_id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.ap_sg_id]
  tags = {
    Name = "${var.project}-webserver-1"
  }
}

resource "aws_instance" "webserver_2" {
  ami                    = var.ami_ubuntu-2404_id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.ap_sg_id]
  tags = {
    Name = "${var.project}-webserver-2"
  }
}

# ----- output -----

output "webserver_1_instance_id" {
  value = aws_instance.webserver_1.id
}

output "webserver_2_instance_id" {
  value = aws_instance.webserver_2.id
}

