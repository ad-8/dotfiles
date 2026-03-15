{ config, lib, ... }:

{
  options = {
    configMegasync.enable = lib.mkEnableOption "Enable Megasync";
  };

  config = lib.mkIf config.configMegasync.enable {
    services.megasync = {
      enable = true;
      forceWayland = true;
    };
  };
}
