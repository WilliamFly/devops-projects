output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.devops_server.id
}

output "public_ip" {
  description = "Public IP address of the server"
  value       = aws_eip.devops_eip.public_ip
}

output "public_dns" {
  description = "Public DNS of the server"
  value       = aws_instance.devops_server.public_dns
}
