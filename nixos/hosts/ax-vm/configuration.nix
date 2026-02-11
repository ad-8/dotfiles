{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/vm/default.nix
  ];

  networking.hostName = "ax-vm";

  system.stateVersion = "25.05"; # Did you read the comment?
}
