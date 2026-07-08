output "bastion_public_ip" {
  value = aws_eip.bastion_eip.public_ip
}

output "private_server_private_ip" {
  value = aws_instance.private_server.private_ip
}
