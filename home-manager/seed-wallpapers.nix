{ pkgs, lib, ... }:
{
  home.activation.seedDefaultWallpaper = lib.hm.dag.entryAfter [ "cloneWallpapers" ] ''
    if [ ! -f "$HOME/.current_wallpaper/currentwallpaper.png" ]; then
      default_wall="$HOME/media/wallpapers/default.png"
      if [ -f "$default_wall" ]; then
        $DRY_RUN_CMD ${pkgs.change-wallpaper}/bin/change-wallpaper "$default_wall"
      fi
    fi
  '';
}
