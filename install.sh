#!/bin/sh
set -e
nix-shell -p git --run "git clone https://github.com/brighamdent/nixbox.git /tmp/nixbox"
echo "Available disks:"
lsblk
read -p "Enter target device (e.g. /dev/nvme0n1): " device
sudo nix run github:nix-community/disko -- \
  --mode disko \
  --flake /tmp/nixbox#nixbox \
  --arg device "\"$device\""
sudo nixos-install --flake /tmp/nixbox#nixbox
echo "Install complete. Run 'reboot' when ready."
