{ pkgs, lib, ... }:
{
  home.activation.cloneNixConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.nixos/.git" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/brighamdent/nixos-config.git "$HOME/.nixos"
    fi
  '';
}
