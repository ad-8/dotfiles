{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration-core.nix
    ../ax-configs.nix
  ];

  configExtra.enable = true;
  configPrinting.enable = true;
  configVirtman.enable = false;

  boot.initrd.luks.devices."luks-f43e8971-1fb7-4d8c-be86-c8162a78d104".device =
    "/dev/disk/by-uuid/f43e8971-1fb7-4d8c-be86-c8162a78d104";
  networking.hostName = "ax-mac"; # Define your hostname.

  # ignore short presses of the power button entirely. Long-pressing your power button (5 seconds or longer)
  # to do a hard reset is handled by your machine’s BIOS/EFI and thus still possible.
  # (https://wiki.nixos.org/wiki/Systemd/logind)
  services.logind.settings.Login.HandlePowerKey = "ignore"; # started working after a reboot

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            # Maps capslock to escape when pressed and control when held.
            capslock = "overload(control, esc)";
            # Remaps the escape key to capslock
            # esc = "capslock";
          };
        };
      };
    };
  };

  # laptop battery info via `upower --dump`
  services.upower.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
