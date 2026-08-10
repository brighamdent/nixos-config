{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      display = {
        color = "blue";
        separator = "  ";
      };

      modules = [
        "break"
        "break"
        { type = "custom"; }
        {
          type = "custom";
          format = "╭───────────────────────────────╮";
        }
        {
          type = "os";
          key = " ❄️";
          format = "{2}";
        }
        {
          type = "host";
          key = "  ";
          format = "{3}";
        }
        {
          type = "kernel";
          key = "  ";
        }
        {
          type = "wm";
          key = "  ";
        }
        {
          type = "shell";
          key = " $ ";
        }
        {
          type = "terminal";
          key = "  ";
        }
        {
          type = "uptime";
          key = " 󰔚 ";
        }
        {
          type = "packages";
          key = "  ";
        }
        {
          type = "memory";
          key = " 󰍛 ";
        }
        {
          type = "disk";
          key = "  ";
          folders = "/:/home:/boot:/efi";
          format = "{1}/{2} {3}";
        }
        {
          type = "custom";
          format = "╰───────────────────────────────╯";
        }
        {
          type = "custom";
          format = builtins.fromJSON ''"     \u001b[90m\u25cf  \u001b[31m\u25cf  \u001b[32m\u25cf  \u001b[33m\u25cf  \u001b[34m\u25cf  \u001b[35m\u25cf  \u001b[36m\u25cf  \u001b[37m\u25cf "'';
        }
      ];
    };
  };
}
