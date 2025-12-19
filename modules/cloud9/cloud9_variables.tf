variable "project" {
  description = "Project name prefix used for tagging resources"
  type        = string
}

variable "public_subnet_1_id" {
  description = "Subnet ID for Manager node"
  type        = string
}

variable "cloud9_image_id" {
  description = "Amazon Linux 2023"
  type        = string
  default     = "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64"
}

