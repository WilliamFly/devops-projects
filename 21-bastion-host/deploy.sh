#!/bin/bash
set -e

echo "=== Running terraform apply ==="
terraform init -input=false
terraform apply -auto-approve

echo "=== Capturing IPs from Terraform output ==="
BASTION_IP=$(terraform output -raw bastion_public_ip)
PRIVATE_IP=$(terraform output -raw private_server_private_ip)
echo "Bastion IP: ${BASTION_IP}"
echo "Private Server IP: ${PRIVATE_IP}"

echo "=== Writing inventory.ini ==="
cat > inventory.ini << EOT
[bastion]
${BASTION_IP} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/devops-key.pem

[private]
${PRIVATE_IP} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/devops-key.pem ansible_ssh_common_args='-o ProxyCommand="ssh -i ~/.ssh/devops-key.pem -W %h:%p -q ubuntu@${BASTION_IP}"'
EOT

echo "=== Writing local SSH config entries ==="
cat > ssh-config-snippet.txt << EOT
Host bastion
    HostName ${BASTION_IP}
    User ubuntu
    IdentityFile ~/.ssh/devops-key.pem

Host private-server
    HostName ${PRIVATE_IP}
    User ubuntu
    ProxyJump bastion
    IdentityFile ~/.ssh/devops-key.pem
EOT
echo "Append ssh-config-snippet.txt to your ~/.ssh/config to enable 'ssh bastion' / 'ssh private-server' shortcuts."

echo "=== Waiting for SSH to become available on bastion ==="
for i in {1..15}; do
  if ssh -i ~/.ssh/devops-key.pem -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@${BASTION_IP} "echo SSH ready" 2>/dev/null; then
    break
  fi
  echo "Waiting for bastion SSH... (attempt ${i}/15)"
  sleep 10
done

echo "=== Waiting for SSH to become available on private server (via bastion) ==="
for i in {1..15}; do
  if ssh -i ~/.ssh/devops-key.pem -o StrictHostKeyChecking=no -o ConnectTimeout=5 \
     -o ProxyCommand="ssh -i ~/.ssh/devops-key.pem -W %h:%p -q ubuntu@${BASTION_IP}" \
     ubuntu@${PRIVATE_IP} "echo SSH ready" 2>/dev/null; then
    break
  fi
  echo "Waiting for private server SSH... (attempt ${i}/15)"
  sleep 10
done

echo "=== Running Ansible playbook ==="
ansible-playbook site.yml -i inventory.ini

echo "=== Deployment complete ==="
echo "Bastion: ${BASTION_IP}"
echo "Private server (internal): ${PRIVATE_IP}"
echo "Append ssh-config-snippet.txt to ~/.ssh/config, then: ssh bastion / ssh private-server"
