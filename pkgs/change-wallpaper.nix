{
  writeShellApplication,
  pywal,
  swww,
  magick,
}:

writeShellApplication {
  name = "change-wallpaper";
  runtimeInputs = [
    pywal
    swww
    magick
  ];
  text = builtins.readFile ../scripts/change-wallpaper.sh;
}
