{ pkgs, isVm ? false, ... }:
let
  kittyPackage =
    if isVm then
      pkgs.symlinkJoin {
        name = "kitty-sw";
        paths = [ pkgs.kitty ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/kitty --set LIBGL_ALWAYS_SOFTWARE 1
        '';
      }
    else
      pkgs.kitty;
in
{
  programs.kitty = {
    enable = true;
    package = kittyPackage;
    shellIntegration = {
      # enableFishIntegration = true;
      mode = null;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
    };

    settings = {
      background_opacity = "0.1";
      window_padding_width = 10;
      cursor_shape = "block";
      cursor_trail = 3;

    };

    keybindings = {
      "ctrl+u" = "scroll_line_up";
      "ctrl+d" = "scroll_line_down";
    };
  };
}
