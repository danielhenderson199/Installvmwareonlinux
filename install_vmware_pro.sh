#!/bin/bash

set -e

# Configurable settings
VMWARE_URL="https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle"
BUNDLE_NAME="VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle"

# Root check
if [[ $EUID -ne 0 ]]; then
    echo "❌ Please run this script as root (sudo)."
    exit 1
fi

# Install dependencies
echo "📦 Installing build tools and headers..."
apt update
apt install -y build-essential linux-headers-$(uname -r) dkms

# Download VMware Workstation Pro
echo "⬇️ Downloading VMware Workstation Pro..."
wget -O "$BUNDLE_NAME" "$VMWARE_URL"

# Make it executable
chmod +x "$BUNDLE_NAME"

# Run installer silently
echo "🚀 Installing VMware Workstation Pro..."
./"$BUNDLE_NAME" --required --eulas-agreed

# Check installation
if command -v vmware &>/dev/null; then
    echo "✅ VMware Workstation Pro installed successfully!"
else
    echo "⚠️ Installation may have failed. 'vmware' not found in PATH."
fi
