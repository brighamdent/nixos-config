{ pkgs, isVm ? false, ... }:
let
  monitorScale = if isVm then "2" else "1";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    extraConfig = ''
      monitor=,preferred,auto,${monitorScale}
      env = GDK_SCALE,${monitorScale}
    '' + builtins.readFile ../dotfiles/hypr/hyprland.conf;
  };
}
