# This is your home-manager configuration file
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  myPkgs = import ../pkgs pkgs;
in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./fish.nix
    ./dunst.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./waybar.nix
    ./wal.nix
    ./tmux.nix
    ./rofi.nix
    ./kitty.nix
    ./starship.nix
    ./wlogout.nix
    ./nvim.nix
    ./wallpapers.nix
    ./seed-wallpapers.nix
  ];

  home = {
    username = "brigham";
    homeDirectory = "/home/brigham";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        # common.default = [ "gtk" ];
        hyprland.default = [
          # "gtk"
          "hyprland"
        ];
      };
      extraPortals = [
        # pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };

  # wayland.windowManager.hyprland.enable = true;

  # Add stuff for your user as you see fit:
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.fish.enable = true;
  programs.bash.enable = true;
  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.yazi.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.name = "brighamdent";
      user.email = "brighamdent@gmail.com";
    };
  };

  services.dunst.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
  };

  home.packages =
    with pkgs;
    [
      wlogout
      stow
      btop
      gcc
      fd
      fastfetch
      eza
      fzf
      zoxide
      ripgrep
      chromium
      rofi
      vesktop
      pywal
      pavucontrol
      spotify
      xwayland
      swww
      bc
      grim
      slurp
      wl-clipboard
      parted
      unzip
      wireplumber
      imagemagick
      speedtest-cli
      prismlauncher
      cargo
      nodejs
      inotify-tools
    ]
    ++ builtins.attrValues myPkgs;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
