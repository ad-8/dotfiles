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

  boot.initrd.luks.devices."luks-588ac9fc-e3ba-4c6b-b963-b655ebedf967".device =
    "/dev/disk/by-uuid/588ac9fc-e3ba-4c6b-b963-b655ebedf967";
  networking.hostName = "ax-x1c"; # Define your hostname.

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

  programs.slock.enable = true;

  # TODO config e.g. tap to click
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
