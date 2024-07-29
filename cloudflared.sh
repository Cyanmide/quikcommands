#!/bin/bash

# Exit on error
set -e

# Update package list and install dependencies
echo "Updating package list and installing dependencies..."
apt update
apt install -y git curl wget

# Create directory for keyrings
echo "Creating directory for keyrings..."
mkdir -p --mode=0755 /usr/share/keyrings

# Add Cloudflare GPG key
echo "Adding Cloudflare GPG key..."
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add Cloudflare repository
echo "Adding Cloudflare repository..."
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | tee /etc/apt/sources.list.d/cloudflared.list

# Update package list and install cloudflared
echo "Updating package list and installing cloudflared..."
apt-get update
apt-get install -y cloudflared

# Verify installation
echo "Verifying installation..."
cloudflared --version

echo "cloudflared installation complete!"
