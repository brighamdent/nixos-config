{
  writeShellApplication,
  hyprctl,
  magick,
  rofi,
}:

writeShellApplication {
  name = "wallpaper-launcher";
  runtimeInputs = [
    hyprctl
    magick
    rofi
  ];
  text = builtins.readFile ../scripts/wallpaper-launcher.sh;
}
