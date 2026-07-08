#!/bin/bash
set -e

echo "=== Running terraform apply ==="
terraform init -input=false
terraform apply -auto-approve

echo "=== Capturing IP from Terraform output ==="
SERVER_IP=$(terraform output -raw vpn_server_public_ip)
echo "VPN Server IP: ${SERVER_IP}"

echo "=== Writing inventory.ini ==="
cat > inventory.ini << EOT
[vpn_server]
${SERVER_IP} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/devops-key.pem
EOT

echo "=== Waiting for SSH to become available ==="
for i in {1..15}; do
  if ssh -i ~/.ssh/devops-key.pem -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${SERVER_IP} "echo SSH ready" 2>/dev/null; then
    break
  fi
  echo "Waiting for SSH... (attempt ${i}/15)"
  sleep 10
done

echo "=== Running Ansible playbook ==="
ansible-playbook site.yml -i inventory.ini

echo "=== Downloading client config to local machine ==="
scp -i ~/.ssh/devops-key.pem -o StrictHostKeyChecking=no ubuntu@${SERVER_IP}:/home/ubuntu/client.conf ./client.conf

echo "=== Deployment complete ==="
echo "VPN Server IP: ${SERVER_IP}"
echo "Client config downloaded to: ./client.conf"
echo "Import this into your WireGuard client to connect."
