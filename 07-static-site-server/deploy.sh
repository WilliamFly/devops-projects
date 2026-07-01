#!/bin/bash

SERVER_USER="ubuntu"
SERVER_IP="18.116.162.61"
REMOTE_DIR="/var/www/html/"
LOCAL_DIR="./site/"
SSH_KEY="~/.ssh/devops-key.pem"

echo "Deploying static site to $SERVER_IP..."

rsync -avz --delete \
  -e "ssh -i $SSH_KEY" \
  $LOCAL_DIR \
  $SERVER_USER@$SERVER_IP:$REMOTE_DIR

echo "Deployment complete!"
