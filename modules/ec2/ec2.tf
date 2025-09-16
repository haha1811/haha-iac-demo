resource "aws_instance" "openvpn" {
  ami           = var.ami_openvpn_id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_1_id
  key_name      = var.manager_key_pair
  vpc_security_group_ids = [var.openvpn_sg_id]
  tags = {
    Name = "${var.project}-openvpn"
  }
}

resource "aws_eip_association" "openvpn" {
  instance_id   = aws_instance.openvpn.id
  allocation_id = var.eip_openvpn_id
}

resource "aws_instance" "ap1" {
  ami           = var.ami_ap_id
  instance_type = "t3.micro"
  subnet_id     = var.private_subnet_1_id
  key_name      = var.manager_key_pair
  vpc_security_group_ids = [var.ap_sg_id]
  tags = {
    Name = "${var.project}-ap1"
  }
}

