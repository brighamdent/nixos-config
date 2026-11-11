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
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  systemd.services.install-flatpaks = {
    description = "Install declared Flatpaks";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "flatpak-system-helper.service" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak install -y --noninteractive flathub dev.vencord.Vesktop
    '';
  };

  system.stateVersion = "25.11";
}
