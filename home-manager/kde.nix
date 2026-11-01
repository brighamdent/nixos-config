{config, ...}:

{
  xdg.configFile."kdeglobals".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/Pywal.colors";

  xdg.dataFile."color-schemes/Pywal.colors".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/wal/Pywal.colors";
}
