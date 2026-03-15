{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    configSecretService.enable = lib.mkEnableOption "Enable Gnome Keyring";
  };

  config = lib.mkIf config.configSecretService.enable {
    # https://wiki.nixos.org/wiki/Secret_Service
    services.gnome-keyring.enable = true;
    home.packages = [ pkgs.gcr ]; # Provides org.gnome.keyring.SystemPrompter
  };
}
