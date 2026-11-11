{ pkgs, isVm ? false, ... }:
let
  monitorScale = if isVm then "2" else "1";
  vmEnv = if isVm then ''
    env = LIBGL_ALWAYS_SOFTWARE,1
  '' else "";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    extraConfig = ''
      monitor=,preferred,auto,${monitorScale}
      env = GDK_SCALE,${monitorScale}
      ${vmEnv}
    '' + builtins.readFile ../dotfiles/hypr/hyprland.conf;
  };
}
