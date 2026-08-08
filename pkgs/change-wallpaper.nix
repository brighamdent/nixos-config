{
  writeShellApplication,
  pywal,
  swww,
  imagemagick,
}:

writeShellApplication {
  name = "change-wallpaper";
  runtimeInputs = [
    pywal
    swww
    imagemagick
  ];
  text = builtins.readFile ../scripts/change-wallpaper.sh;
}
