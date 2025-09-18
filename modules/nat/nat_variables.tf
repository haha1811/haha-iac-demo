variable "vpc_id" {
  description = "VPC ID for NAT Gateway dependency"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID to associate the NAT Gateway"
  type        = string
}

variable "project" {
  description = "Project name prefix used for tagging resources"
  type        = string
}

variable "private_rt_id" {
  description = "Private route table ID"
  type        = string
}

#variable "nat_gateway_id" {
#  description = "NAT Gateway ID"
#  type        = string
#}