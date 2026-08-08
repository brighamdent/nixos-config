{ pkgs, ... }:
{
  home.packages = with pkgs; [ pywal ];

  xdg.configFile."wal/templates" = {
    source = ../dotfiles/wal/templates;
    recursive = true;
  };
}
