{ config, ... }:
{
  programs.vesktop = {
    enable = true;
    vencord.settings = {
      enabledThemes = [ "wal.css" ];
      transparent = true;
    };
  };

  xdg.configFile."vesktop/themes/wal.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/vesktop.css";
}
