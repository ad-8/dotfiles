{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/laptop/default.nix
  ];

  boot.initrd.luks.devices."luks-588ac9fc-e3ba-4c6b-b963-b655ebedf967".device =
    "/dev/disk/by-uuid/588ac9fc-e3ba-4c6b-b963-b655ebedf967";

  networking.hostName = "ax-x1c";

  system.stateVersion = "25.05"; # Did you read the comment?
}
