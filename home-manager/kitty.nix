{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
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
