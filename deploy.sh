#!/bin/bash
set -e

# === CONFIGURATION ===
APP_NAME="frontend-the-aitelier"
REMOTE_USER="root"
REMOTE_HOST="YOUR.SERVER.IP"         
REMOTE_PATH="/app"                  
SSH_KEY="~/.ssh/id_rsa_coolify"     

# === BUILD ===
echo "🔨 Building Next.js app..."
npm install
npm run build

# === DEPLOY ===
echo "🚀 Uploading project to server..."
scp -i $SSH_KEY -r . "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

echo "✅ Upload complete."
echo "🔁 Restarting app via Docker (optional)..."

ssh -i $SSH_KEY "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_PATH && docker restart \$(docker ps --filter name=$APP_NAME -q)"
