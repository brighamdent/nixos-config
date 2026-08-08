{
  writeShellApplication,
  hyprland,
  imagemagick,
  rofi,
}:

writeShellApplication {
  name = "wallpaper-launcher";
  runtimeInputs = [
    hyprland
    imagemagick
    rofi
  ];
  text = builtins.readFile ../scripts/wallpaper-launcher.sh;
}
