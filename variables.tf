variable "aws_region" {
  description = "AWS region to deploy the lab"
  type        = string
  default     = "us-west-2"
}

variable "student_name" {
  description = "Student identifier for resource naming"
  type        = string
  default     = "nathan"
}

variable "course_id" {
  description = "Course identifier"
  type        = string
  default     = "it3200"
}

variable "instance_type" {
  description = "AWS Free Tier eligible instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 Key Pair name for SSH/RDP access"
  type        = string
}

variable "allowed_cidr" {
  description = "CIDR block allowed to connect to SSH/RDP (recommend your IP/32)"
  type        = string
  default     = "0.0.0.0/0"
}
