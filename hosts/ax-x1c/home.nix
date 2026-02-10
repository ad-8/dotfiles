{ lib, ... }:

{
  imports = [
    ../../home-manager/default.nix
  ];
  # TODO how to change the defaults
  configQt.enable = lib.mkForce true;
}
