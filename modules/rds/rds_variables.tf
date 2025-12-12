variable "project" {
  description = "Project name prefix used for tagging resources"
  type        = string
}

variable "private_subnet_ids" {
  description = "VPC Private Subnet IDs"
  type        = list(string)                # 一組字串要用 list(string)。
}


variable "aurora_db_name" {
  description = "Aurora Serverless V2 DB Name"
  type        = string
}

variable "aurora_master_username" {
  description = "Aurora Serverless V2 Username"
  type        = string
}

variable "aurora_master_password" {
  description = "Aurora Serverless V2 User Password"
  type        = string
}

variable "db_sg_id" {
  description = "Aurora Serverless V2 DB SG ID"
  type        = string
}

variable "alarm_sns_topic_arn" {
  type        = string
  description = "SNS topic ARN for RDS alarms"
}

