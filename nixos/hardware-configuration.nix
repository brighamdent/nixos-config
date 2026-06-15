# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{
  boot.loader.systemd-boot.enable = true;

  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/sda3";
    fsType = "ext4";
  };

  fileSystems."/home/brigham/games" = {
    device = "/dev/nvme0n1p1";
    fsType = "ext4";
  };

  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = "x86_64-linux";
}
