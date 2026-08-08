# hosts/common.nix
# Config shared by every host. Import this in every nixosConfigurations entry.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  ##### Nix settings #####
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
    };
    channel.enable = false;
  };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  ##### Boot #####
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##### Base packages / shell #####
  environment.systemPackages = with pkgs; [
    home-manager
  ] ++ [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  programs.fish.enable = true;

  ##### Networking / time / auth #####
  networking.networkmanager.enable = true;
  services.timesyncd.enable = true;
  services.geoclue2.enable = true;
  services.automatic-timezoned.enable = true;
  security.polkit.enable = true;
  services.udisks2.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  ##### Fonts #####
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  ##### Users #####
  users.users.root.hashedPassword = "$6$ro2TVsd4nlqrwRAw$kcbDBH4Jh8n/sG8QvGbVZP1J6upJIRYflWXd4GiK2Ma3nzb0V6XAHf0oNTB99dIeFif6AgYAp0v6lgOlhPwCM/";

  users.users.brigham = {
    hashedPassword = "$6$ro2TVsd4nlqrwRAw$kcbDBH4Jh8n/sG8QvGbVZP1J6upJIRYflWXd4GiK2Ma3nzb0V6XAHf0oNTB99dIeFif6AgYAp0v6lgOlhPwCM/";
    isNormalUser = true;
    shell = pkgs.fish;
    # Host-specific groups (e.g. "uinput" for Sunshine) get merged in
    # from each host's own configuration.nix — NixOS concatenates
    # list-type options like extraGroups across files automatically.
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  ##### GUI / desktop-tier #####
  # Everything below is for hosts with a display. If you add a headless
  # server host later, split this section into hosts/desktop-tier.nix
  # and only import it on hosts that need it.

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  hardware.graphics.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
  '';
}
