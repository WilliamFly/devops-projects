variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "ami_id" {
  description = "Ubuntu 24.04 LTS AMI ID for us-east-2"
  type        = string
  default     = "ami-0933f4f9e0a0fc3a5"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
  default     = "devops-key"
}
