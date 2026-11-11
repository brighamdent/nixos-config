{ config, lib, pkgs, isVm ? false, ... }:
let
  vencordSettingsSeed = pkgs.writeText "vencord-settings.json" (builtins.toJSON {
    enabledThemes = [ "wal.css" ];
    transparent = true;
  });
in
{
  programs.vesktop.enable = !isVm;

  xdg.configFile."vesktop/themes/wal.css" = lib.mkIf (!isVm) {
    source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/vesktop.css";
  };

  home.activation.vesktopSeedSettings = lib.mkIf (!isVm) (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.config/vesktop/settings"
    target="$HOME/.config/vesktop/settings/settings.json"
    if [ -L "$target" ]; then
      run rm -f "$target"
    fi
    if [ ! -e "$target" ]; then
      run install -m 0644 ${vencordSettingsSeed} "$target"
    fi
  '');
}
