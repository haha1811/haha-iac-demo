variable "project" {
  description = "Project name prefix used for tagging resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_1_id" {
  description = "Subnet ID for Manager node"
  type        = string
}

variable "public_subnet_2_id" {
  description = "Subnet ID for Manager node"
  type        = string
}

variable "private_subnet_1_id" {
  description = "Subnet IDs for Worker nodes"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Subnet IDs for Worker nodes"
  type        = string
}

variable "manager_key_pair" {
  description = "Key pair for EC2 SSH login"
  type        = string
}

variable "ami_openvpn_id" {
  description = "OPENVPN AMIs ID"
  type        = string
  default     = "ami-0e88f24435ee93ef4"
}

variable "ami_windows-2025_id" {
  description = "AP AMIs ID"
  type        = string
  default     = "ami-0910ccfe3edc72362"
}

variable "ami_ubuntu-2404_id" {
  description = "AP AMIs ID"
  type        = string
  default     = "ami-0a71a0b9c988d5e5e"
}

variable "openvpn_sg_id" {
  description = "OPENVPN SG ID"
  type        = string
}

variable "db_sg_id" {
  description = "DB SG"
  type        = string
}

variable "ap_sg_id" {
  description = "AP SG"
  type        = string
}


