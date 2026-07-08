terraform {
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

# Security Group - Bastion (public)
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from the internet to the bastion host"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

# Security Group - Private Server (only reachable from bastion)
resource "aws_security_group" "private_sg" {
  name        = "private-server-sg"
  description = "Allow SSH only from the bastion host"

  ingress {
    description     = "SSH from bastion only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-server-sg"
  }
}

# Bastion Host - public
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name        = "bastion-host"
    Environment = "practice"
    Project     = "roadmap-devops-project21"
  }
}

# Private Server - no public IP
resource "aws_instance" "private_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  associate_public_ip_address = false

  tags = {
    Name        = "private-server"
    Environment = "practice"
    Project     = "roadmap-devops-project21"
  }
}

# Elastic IP - Bastion only
resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
  domain   = "vpc"

  tags = {
    Name = "bastion-eip"
  }
}
