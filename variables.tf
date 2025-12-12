variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "project" {
  default = "haha-iac-demo"
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair to use"
}

# CloudWatch / SNS 告警收信人
variable "alert_email" {
  description = "Email address to alarms"
  type        = string
}

# Aurora DB 設定
variable "aurora_db_name" {
  description = "Default database name in Aurora PostgreSQL"
  type        = string
  sensitive   = true
}

variable "aurora_master_username" {
  description = "Master username for Aurora PostgreSQL"
  type        = string
  sensitive   = true
}

variable "aurora_master_password" {
  description = "Master password for Aurora PostgreSQL"
  type        = string
  sensitive   = true
}
