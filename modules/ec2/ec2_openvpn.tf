resource "aws_instance" "openvpn" {
  ami                    = var.ami_openvpn_id
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_1_id
  key_name               = var.manager_key_pair
  vpc_security_group_ids = [var.openvpn_sg_id]
  tags = {
    Name = "${var.project}-openvpn"
  }
}


# ---- EIP ----

resource "aws_eip" "openvpn" {
  domain = "vpc"
  tags = {
    Name = "${var.project}-eip-openvpn"
  }
}


# ---- Attached ----

resource "aws_eip_association" "openvpn" {
  instance_id   = aws_instance.openvpn.id
  allocation_id = aws_eip.openvpn.id
}


# ---- outputs ----

output "eip_openvpn_id" {
  value = aws_eip.openvpn.id
}

