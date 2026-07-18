# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
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
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

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

  home.packages = with pkgs; [
    hyprland
    hyprlock
    wlogout
    kitty
    tmux
    stow
    btop
    gcc
    fastfetch
    eza
    fzf
    zoxide
    starship
    ripgrep
    chromium
    rofi
    vesktop
    waybar
    pywal
    pavucontrol
    spotify
    xwayland
    mangohud
    swww
    bc
    grim
    slurp
    wl-clipboard
    parted
    gamemode
    unzip
    wireplumber
    imagemagick
    speedtest-cli
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
