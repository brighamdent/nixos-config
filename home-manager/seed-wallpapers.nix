{ pkgs, lib, ... }:
{
  home.activation.seedDefaultWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "$HOME/.current_wallpaper/currentwallpaper.png" ]; then
      default_wall="$HOME/media/wallpapers/default.png"
      if [ -f "$default_wall" ]; then
        mkdir -p "$HOME/.current_wallpaper"
        $DRY_RUN_CMD ${pkgs.pywal}/bin/wal -i "$default_wall" -n || true
        $DRY_RUN_CMD ${pkgs.imagemagick}/bin/magick convert "$default_wall" \
          "$HOME/.current_wallpaper/currentwallpaper.png" || true
        $DRY_RUN_CMD ${pkgs.imagemagick}/bin/magick convert \
          "$HOME/.current_wallpaper/currentwallpaper.png" \
          -scale 10% -blur 0x4 -resize 1000% \
          "$HOME/.current_wallpaper/currentwallpaperblurred.png" || true
      fi
    fi
  '';
}
