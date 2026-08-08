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

  networking.hostName = "nixbook";

  ##### Power management — desktop doesn't need this #####
  services.power-profiles-daemon.enable = true;
  # or, mutually exclusive with the above:
  # services.tlp.enable = true;

  services.thermald.enable = true;

  ##### Lid / suspend behavior #####
  services.logind.settings.Login.HandleLidSwitch = "suspend";
  # services.logind.lidSwitchExternalPower = "ignore"; # e.g. stay awake on AC with lid closed

  ##### GPU — depends entirely on the actual hardware #####
  # Intel/AMD integrated: usually nothing extra needed beyond kernel defaults.
  # Nvidia Optimus/hybrid: would need hardware.nvidia.prime config here,
  # which looks nothing like the desktop's single-GPU nvidia block.

  system.stateVersion = "25.11"; # whatever nixos-generate-config gives THIS install
}
