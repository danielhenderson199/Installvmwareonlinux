#!/bin/bash
set -e

# VMware Workstation Pro download URL (v17.5.0)
VMWARE_URL="https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle"
BUNDLE="VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle"

check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "Please run this script with sudo or as root."
    exit 1
  fi
}

install_dependencies() {
  echo "Updating package lists..."
  apt update

  echo "Installing build tools, dkms, and kernel headers..."
  apt install -y build-essential dkms linux-headers-$(uname -r) wget
}

download_vmware() {
  echo "Downloading VMware Workstation Pro installer..."
  wget -O "$BUNDLE" "$VMWARE_URL"
  chmod +x "$BUNDLE"
}

install_vmware() {
  echo "Running VMware installer..."
  ./"$BUNDLE" --required --eulas-agreed
}

main() {
  check_root
  install_dependencies
  download_vmware
  install_vmware

  echo "VMware Workstation Pro installation complete."
  echo "You can now run VMware by typing 'vmware' in your terminal."
}

main
