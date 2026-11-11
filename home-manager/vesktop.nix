{ config, lib, pkgs, ... }:
let
  vencordSettingsSeed = pkgs.writeText "vencord-settings.json" (builtins.toJSON {
    enabledThemes = [ "wal.css" ];
    transparent = true;
  });
in
{
  programs.vesktop.enable = true;

  xdg.configFile."vesktop/themes/wal.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/vesktop.css";

  home.activation.vesktopSeedSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.config/vesktop/settings"
    target="$HOME/.config/vesktop/settings/settings.json"
    if [ -L "$target" ]; then
      run rm -f "$target"
    fi
    if [ ! -e "$target" ]; then
      run install -m 0644 ${vencordSettingsSeed} "$target"
    fi
  '';
}
