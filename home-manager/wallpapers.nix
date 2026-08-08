{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.activation.cloneWallpapers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/media"
    if [ ! -d "$HOME/media/wallpapers/.git" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/brighamdent/wallpapers.git "$HOME/media/wallpapers"
    fi
  '';
}
