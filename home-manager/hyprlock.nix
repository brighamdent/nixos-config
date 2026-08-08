{ pkgs, ... }:
{
  programs.hyprlock.enable = true;
  home.file.".config/hypr/hyprlock.conf".source = ../dotfiles/hypr/hyprlock.conf;
}
