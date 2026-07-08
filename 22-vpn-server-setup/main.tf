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

resource "aws_security_group" "vpn_sg" {
  name        = "vpn-sg"
  description = "Allow SSH and WireGuard traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "WireGuard"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpn-sg"
  }
}

resource "aws_instance" "vpn_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.vpn_sg.id]

  tags = {
    Name        = "vpn-server"
    Environment = "practice"
    Project     = "roadmap-devops-project22"
  }
}

resource "aws_eip" "vpn_eip" {
  instance = aws_instance.vpn_server.id
  domain   = "vpc"

  tags = {
    Name = "vpn-eip"
  }
}
