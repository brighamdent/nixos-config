{ config, lib, pkgs, isVm ? false, ... }:
let
  vencordSettingsSeed = pkgs.writeText "vencord-settings.json" (builtins.toJSON {
    enabledThemes = [ "wal.css" ];
    transparent = true;
  });
  wrappedVesktop = pkgs.symlinkJoin {
    name = "vesktop-vm";
    paths = [ pkgs.vesktop ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/bin/vesktop
      makeWrapper ${pkgs.vesktop}/bin/vesktop $out/bin/vesktop \
        --add-flags "--disable-gpu" \
        --add-flags "--ozone-platform=x11" \
        --add-flags "--force-device-scale-factor=2"
    '';
  };
  vesktopPackage =
    if isVm then
      wrappedVesktop // {
        override = _: wrappedVesktop;
        inherit (pkgs.vesktop) pname version meta;
      }
    else
      pkgs.vesktop;
in
{
  programs.vesktop = {
    enable = true;
    package = vesktopPackage;
  };

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
