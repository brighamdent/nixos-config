#!/bin/sh
# Defining the path to the Rofi theme file
rofi_theme_file="$HOME/.config/rofi/config.rasi"

# Using sed to replace the background-image path within the inputbar section of the .rasi (rofi) file
sed -i "/inputbar {/,/}/ s|url(\"[^\"]*\", width)|url(\"$1\", width)|" "$rofi_theme_file"

#Changes background using swww
swww img --transition-type wipe --transition-angle 30 --transition-step 200 "$1"

#Sets pywal color scheme
wal -i "$1" -n

mkdir -p "$HOME/.current_wallpaper"

echo "$(date) - Converting wallpaper: $1"
which magick >> /tmp/wallpaper.log
magick convert "$1" "$HOME/.current_wallpaper/currentwallpaper.png" \
  >> /tmp/wallpaper.log 2>&1

echo "$(date) - Generating blurred wallpaper"
magick convert \
    "$HOME/.current_wallpaper/currentwallpaper.png" \
    -scale 10% \
    -blur 0x4 \
    -resize 1000% \
    "$HOME/.current_wallpaper/currentwallpaperblurred.png" \
    && echo "$(date) - Blur generation successful" \
    || echo "$(date) - Blur generation failed"
