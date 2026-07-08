#!/bin/bash
set -e

echo "=== Loading local R2 credentials ==="
if [ ! -f .env.deploy ]; then
  echo "ERROR: .env.deploy not found. Create it with R2 credentials first."
  exit 1
fi
source .env.deploy

echo "=== Running terraform apply ==="
terraform init -input=false
terraform apply -auto-approve

echo "=== Capturing server IP from Terraform output ==="
SERVER_IP=$(terraform output -raw public_ip)
echo "Server IP: ${SERVER_IP}"

echo "=== Writing inventory.ini ==="
cat > inventory.ini << EOT
[db_backup_server]
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
ansible-playbook server_setup.yml -i inventory.ini \
  -e "r2_access_key_id=${R2_ACCESS_KEY_ID} r2_secret_access_key=${R2_SECRET_ACCESS_KEY} r2_bucket_name=${R2_BUCKET_NAME} r2_account_id=${R2_ACCOUNT_ID}"

echo "=== Deployment complete ==="
echo "Server IP: ${SERVER_IP}"
echo "Test the backup manually with: ssh -i ~/.ssh/devops-key.pem ubuntu@${SERVER_IP} '/opt/db-backup/backup.sh'"
