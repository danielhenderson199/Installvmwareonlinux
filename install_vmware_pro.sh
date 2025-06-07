#!/bin/bash
set -e

VMWARE_URL="https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle"
BUNDLE="VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle"

check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root (sudo)."
    exit 1
  fi
}

download_vmware() {
  echo "Downloading VMware Workstation Pro installer..."
  wget -O "$BUNDLE" "$VMWARE_URL"
  chmod +x "$BUNDLE"
}

install_vmware_no_modules() {
  echo "Installing VMware Workstation Pro WITHOUT building kernel modules..."
  ./"$BUNDLE" --console --eulas-agreed --required --ignore-kernel-modules
}

main() {
  check_root
  download_vmware
  install_vmware_no_modules

  echo "Installation finished. NOTE: VMware kernel modules are NOT built."
  echo "VMware might NOT work properly without kernel modules."
}

main
