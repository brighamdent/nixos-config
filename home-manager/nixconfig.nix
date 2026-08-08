{ pkgs, lib, ... }:
{
  home.activation.cloneNixConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for i in $(seq 1 30); do
      if ${pkgs.curl}/bin/curl -s --head https://github.com > /dev/null 2>&1; then
        break
      fi
      sleep 1
    done
    if [ ! -d "$HOME/.nixos/.git" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/brighamdent/nixos-config.git "$HOME/.nixos"
    fi
  '';
}
