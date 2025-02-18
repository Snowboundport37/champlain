#!/bin/bash

# Ensure script is run with one argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1
USER_HOME="/home/$USERNAME"

# Create user if it doesn't exist
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists."
else
    sudo useradd -m -s /bin/bash "$USERNAME"
    echo "User $USERNAME created."
fi

# Ensure SSH directory exists
sudo mkdir -p "$USER_HOME/.ssh"
sudo chmod 700 "$USER_HOME/.ssh"

# Check if public key exists before proceeding
if [ ! -f "/home/champuser/champlain/linux/public-keys/web01-id_rsa.pub" ]; then
    echo "Error: Public key not found!"
    exit 1
fi

# Copy the public key to the user's authorized_keys file
sudo cp "/home/champuser/champlain/linux/public-keys/web01-id_rsa.pub" "$USER_HOME/.ssh/authorized_keys"
sudo chmod 600 "$USER_HOME/.ssh/authorized_keys"
sudo chown -R "$USERNAME:$USERNAME" "$USER_HOME/.ssh"

echo "SSH Key added for $USERNAME."

# Restart SSH service
sudo systemctl restart sshd

echo "User $USERNAME created and SSH secured."

