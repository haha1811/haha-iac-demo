output "openvpn_sg_id" {
  value = aws_security_group.openvpn_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "ap_sg_id" {
  value = aws_security_group.ap_sg.id
}

