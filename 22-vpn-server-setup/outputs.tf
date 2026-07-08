output "vpn_server_public_ip" {
  value = aws_eip.vpn_eip.public_ip
}
