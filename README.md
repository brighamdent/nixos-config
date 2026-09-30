# nixos-config
 
Flake-based NixOS + home-manager configuration for my desktop and laptop, with a Hyprland desktop and a one-shot install script that partitions the disk, generates hardware config, and installs the system.
 
## Hosts
 
| Host      | Machine | Config           |
|-----------|---------|------------------|
| `nixbox`  | Desktop | `hosts/desktop`  |
| `nixbook` | Laptop  | `hosts/laptop`   |
 
Shared settings live in `hosts/common.nix`. Disk layout is declared with [disko](https://github.com/nix-community/disko) in `hosts/disko.nix`.
 
## Install
 
From a NixOS live ISO with networking up:
 
```sh
nix-shell -p git --run "git clone https://github.com/brighamdent/nixos-config.git /tmp/bootstrap && sh /tmp/bootstrap/install.sh"
```
 
The script will:
 
1. Ask which host to install (`nixbox` or `nixbook`)
2. Clone this repo and list disks
3. Partition and format the target device with disko (**this wipes the disk**)
4. Regenerate `hardware-configuration.nix` for the host
5. Copy the config to `~/.nixos` and clone my wallpapers into `~/media/wallpapers`
6. Run `nixos-install --flake`
Reboot and log in when it finishes.
 
## Rebuild
 
```sh
sudo nixos-rebuild switch --flake ~/.nixos#nixbox   # or #nixbook
```
 
## Layout
 
```
.
├── flake.nix / flake.lock   # Flake entrypoint and pinned inputs
├── install.sh               # Bootstrap installer
├── hosts/                   # Per-machine config (desktop, laptop) + common + disko
├── home-manager/            # User environment, one module per program
├── modules/                 # Reusable NixOS and home-manager modules
├── overlays/                # Nixpkgs overlays
├── pkgs/                    # Custom packages wrapping the scripts below
├── scripts/                 # Shell scripts packaged via pkgs/
└── dotfiles/                # Raw config files linked in by home-manager
```
 
## What's configured
 
- **Desktop:** Hyprland, Hyprlock, Waybar, Rofi, Dunst, wlogout
- **Terminal:** Kitty, Fish, Starship, Tmux, Neovim, Fastfetch
- **Theming:** pywal (`wal`) with a wallpaper setup seeded from a separate wallpapers repo
