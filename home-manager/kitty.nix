{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ../dotfiles/kitty/kitty.conf;
  };
}
