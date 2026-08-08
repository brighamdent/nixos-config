# hosts/desktop/configuration.nix
# Host-specific config. Shared stuff lives in hosts/common.nix.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # TODO: confirm — set to "desktop" to match the hosts/desktop directory.
  # Change back to "nixbox" if you want the actual reported hostname to differ
  # from the flake attribute / directory name.
  networking.hostName = "nixbox";

  environment.systemPackages = [
    (pkgs.btop.override { cudaSupport = true; })
  ];

  ##### Nvidia #####
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    modesetting.enable = true;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
    open = false;
  };

  ##### Gaming #####
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware.uinput.enable = true;

  # Merges with the "wheel"/"networkmanager" groups already set in common.nix.
  users.users.brigham.extraGroups = [ "uinput" ];

  # Bump needed for some games/Proton titles.
  boot.kernel.sysctl."vm.max_map_count" = lib.mkForce 2147483642;

  systemd.services."home-manager-brigham" = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  # Set when this host was first installed — do NOT copy this value to
  # future hosts. Use whatever nixos-generate-config gives that install.
  system.stateVersion = "25.11";
}
