#!/bin/sh
set -e
export NIX_CONFIG="experimental-features = nix-command flakes"
REPO_URL="https://github.com/brighamdent/nixos-config.git"
WALLPAPER_URL="https://github.com/brighamdent/wallpapers.git"
CLONE_DIR="/tmp/nixos-config"

echo "==> Select host:"
echo "  1) nixbox (desktop)"
echo "  2) nixbook (laptop)"
read -p "Enter choice [1-2]: " host_choice
case "$host_choice" in
  1) FLAKE_HOST="nixbox";  HW_DIR="$CLONE_DIR/hosts/desktop" ;;
  2) FLAKE_HOST="nixbook"; HW_DIR="$CLONE_DIR/hosts/laptop"  ;;
  *) echo "Invalid choice"; exit 1 ;;
esac

rm -rf "$CLONE_DIR"

echo "==> Cloning $REPO_URL"
nix-shell -p git --run "git clone $REPO_URL $CLONE_DIR"

echo "==> Available disks:"
lsblk
read -p "Enter target device (e.g. /dev/nvme0n1): " device

echo "==> Partitioning and formatting via disko"
sudo -E nix run github:nix-community/disko -- \
  --mode disko \
  "$CLONE_DIR/hosts/disko.nix" \
  --argstr device "$device"

echo "==> Regenerating hardware-configuration.nix"
sudo nixos-generate-config --no-filesystems --root /mnt --dir "$HW_DIR"

echo "==> Copying config and wallpapers into new system"
sudo mkdir -p /mnt/home/brigham/media
sudo cp -r "$CLONE_DIR" /mnt/home/brigham/.nixos
nix-shell -p git --run "sudo git clone $WALLPAPER_URL /mnt/home/brigham/media/wallpapers"
sudo chown -R 1000:100 /mnt/home/brigham

echo "==> Installing NixOS"
sudo -E nixos-install --flake "$CLONE_DIR#$FLAKE_HOST"

echo "==> Install complete."
echo "==> Reboot when ready, then log in."
