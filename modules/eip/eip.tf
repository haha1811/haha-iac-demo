resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.project}-eip-nat"
  }
}

resource "aws_eip" "openvpn" {
  domain = "vpc"
  tags = {
    Name = "${var.project}-eip-openvpn"
  }
}


# ---- outputs ----

output "eip_nat_id" {
  value = aws_eip.nat.id
}

output "eip_openvpn_id" {
  value = aws_eip.openvpn.id
}

