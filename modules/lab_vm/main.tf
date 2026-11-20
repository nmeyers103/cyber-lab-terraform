resource "aws_security_group" "vm_sg" {
  name        = "${var.vm_name}-sg"
  description = "Security group for ${var.vm_name}"
  vpc_id      = var.vpc_id

  ingress {
    description = "Remote management access"
    from_port   = var.access_port
    to_port     = var.access_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vm_name}-sg"
  }
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.vm_sg.id]

  tags = {
    Name = var.vm_name
  }
}
