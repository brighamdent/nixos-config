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

  networking.hostName = "nixvm";

  ##### QEMU/KVM guest integration #####
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  ##### Flatpak (for Electron apps that misbehave on aarch64 NixOS) #####
  services.flatpak.enable = true;

  system.stateVersion = "25.11";
}
