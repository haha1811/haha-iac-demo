variable "project" {
  type = string
}

variable "db_1_instance_id" {
  type        = string
  description = "EC2 instance ID to attach volumes to"
}

variable "db_1_availability_zone" {
  type        = string
  description = "AZ must match the instance's AZ"
}

variable "db_2_instance_id" {
  type        = string
  description = "EC2 instance ID to attach volumes to"
}

variable "db_2_availability_zone" {
  type        = string
  description = "AZ must match the instance's AZ"
}

variable "nas_instance_id" {
  type        = string
  description = "EC2 instance ID to attach volumes to"
}

variable "nas_availability_zone" {
  type        = string
  description = "AZ must match the instance's AZ"
}

