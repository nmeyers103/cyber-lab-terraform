terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Fetch default VPC so no custom networking setup is required
data "aws_vpc" "default" {
  default = true
}

# 1. Ubuntu Server 24.04 LTS AMI (Canonical)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Windows Server 2022 Base AMI (Amazon)
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["801119661308"] # Amazon

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}




# Provision Ubuntu VM
module "ubuntu_vm" {
  source        = "./modules/lab_vm"
  vm_name       = "ubuntu-uvu-${var.course_id}-${var.student_name}"
  ami_id        = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_id        = data.aws_vpc.default.id
  access_port   = 22
  allowed_cidr  = var.allowed_cidr
}

# Provision Windows VM
module "windows_vm" {
  source        = "./modules/lab_vm"
  vm_name       = "windows-uvu-${var.course_id}-${var.student_name}"
  ami_id        = data.aws_ami.windows.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_id        = data.aws_vpc.default.id
  access_port   = 3389
  allowed_cidr  = var.allowed_cidr
}

# Provision Kali Linux VM
module "kali_vm" {
  source        = "./modules/lab_vm"
  vm_name       = "kali-uvu-${var.course_id}-${var.student_name}"
  ami_id        = "ami-0659655c95204df80" #
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_id        = data.aws_vpc.default.id
  access_port   = 22
  allowed_cidr  = var.allowed_cidr
}
