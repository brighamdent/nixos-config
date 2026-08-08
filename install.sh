#!/bin/sh
set -e
export NIX_CONFIG="experimental-features = nix-command flakes"
REPO_URL="https://github.com/brighamdent/nixos-config.git"
CLONE_DIR="/tmp/nixos-config"
FLAKE_HOST="nixbox"
rm -rf "$CLONE_DIR"
echo "==> Cloning $REPO_URL"
nix-shell -p git --run "git clone $REPO_URL $CLONE_DIR"
echo "==> Available disks:"
lsblk
read -p "Enter target device (e.g. /dev/nvme0n1): " device
echo "==> Partitioning and formatting via disko"
sudo -E nix run github:nix-community/disko -- \
  --mode disko \
  --flake "$CLONE_DIR#$FLAKE_HOST" \
  --argstr device "$device"
echo "==> Regenerating hardware-configuration.nix (no filesystems, disko owns those)"
sudo nixos-generate-config --no-filesystems --root /mnt --dir "$CLONE_DIR/nixos"
echo "==> Installing NixOS"
sudo -E nixos-install --flake "$CLONE_DIR#$FLAKE_HOST"
echo "==> Install complete."
echo "==> Reboot when ready, then log in."
