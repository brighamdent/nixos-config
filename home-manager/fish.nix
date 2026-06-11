{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    # -------------------------
    # Aliases
    # -------------------------
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      grep = "grep --color=auto";
      vim = "nvim";

      neofetch = "fastfetch";
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      clear = "clear && fastfetch";

      tmfloat = "~/scripts/tmux_session_float.sh";
      tmcode = "~/scripts/tmux_session_code.sh";
      rebuild = "sudo nixos-rebuild switch --flake ~/.nixos#nixbox &&
      home-manager switch --flake ~/.nixos";
    };

    # -------------------------
    # Startup / environment
    # -------------------------
    interactiveShellInit = ''

      cat /home/brigham/.cache/wal/sequences

      # no greeting
      set -g fish_greeting ""

      # PATH
      set -gx PATH $HOME/bin $PATH

      # GUI env vars
      set -gx GTK_THEME Adwaita:dark
      set -gx QT_STYLE_OVERRIDE Adwaita-dark

      # keybinds
      bind \ch backward-kill-word

      # NVIM integration
      if test -n "$NVIM_LISTEN_ADDRESS"
        set -gx MANPAGER "nvr -c 'Man!' -o -"
      end

      # only run when not inside nvim
      if not set -q NVIM
        fastfetch
        starship init fish | source
      end

      # zoxide
      zoxide init --cmd cd fish | source
    '';

    # -------------------------
    # Functions
    # -------------------------
    functions = {
      ff = ''
        set item (find . -type f -print 2>/dev/null | fzf)
        if test -n "$item"
          echo "Opening in nvim: $item"
          nvim "$item"
        end
      '';

      fdir = ''
        find . -type d 2>/dev/null | fzf
      '';
    };
  };
}
