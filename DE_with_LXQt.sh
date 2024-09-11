#!/bin/bash

# Install important packages
apt-get update
apt-get install -y curl wget lshw nvtop lxqt nano

# Download and install KasmVNC
wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.1/kasmvncserver_jammy_1.3.1_amd64.deb
apt-get install ./kasmvncserver_*.deb

# Install ngrok
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
    && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
    | tee /etc/apt/sources.list.d/ngrok.list \
    && apt update \
    && apt install -y ngrok

# Prompt user for ngrok authtoken
read -p "Enter your ngrok authtoken: " NGROK_TOKEN
ngrok config add-authtoken "$NGROK_TOKEN"

# Edit xstartup file
XSTARTUP_FILE="/root/.vnc/xstartup"
mkdir -p "$(dirname "$XSTARTUP_FILE")"
cat <<EOL > "$XSTARTUP_FILE"
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startlxqt &
EOL
chmod +x "$XSTARTUP_FILE"

# Start ngrok tunnel
vncserver

# Start VNC server
ngrok http https://127.0.0.1:8444
