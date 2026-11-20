variable "vm_name" {
  description = "Resource name following resource-uvu-class-studentname"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "access_port" {
  description = "Remote management port (22 for SSH, 3389 for RDP)"
  type        = number
}

variable "allowed_cidr" {
  description = "CIDR block allowed for remote management"
  type        = string
}
