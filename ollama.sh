#!/bin/bash

# Exit on error
set -e

# Update package list and install Nvidia CUDA drivers
echo "Updating package list and installing Nvidia CUDA drivers..."
apt update
apt install -y lshw nvtop

# Install Ollama
echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Start Ollama web server
echo "Starting Ollama web server..."
ollama serve

# Note: The 'ollama serve' command will keep running, and you'll need to stop it manually.
# If you want the script to exit after starting the server, you might need to run 'ollama serve' in the background
# or set it up to start on boot using a service manager like systemd.

echo "Ollama installation and server startup complete!"
