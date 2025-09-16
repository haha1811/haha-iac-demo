

# ---- outputs vpc.tf ----

output "vpc_id" {
  value = aws_vpc.haha_iac_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
  ]
}


# ---- outputs router.tf ----

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}

