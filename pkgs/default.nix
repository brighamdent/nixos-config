# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  tmux-code = pkgs.callPackage ./tmux-code.nix { };
  tmux-float = pkgs.callPackage ./tmux-float.nix { };
  notes-sync = pkgs.callPackage ./notes-sync.nix { };
  change-wallpaper = pkgs.callPackage ./change-wallpaper.nix { };
  wallpaper-launcher = pkgs.callPackage ./wallpaper-launcher.nix { };
}
