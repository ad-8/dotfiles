{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    configAuthAgent.enable = lib.mkEnableOption "Enable Auth Agent for polkit";
  };

  config = lib.mkIf config.configAuthAgent.enable {
    # https://wiki.nixos.org/wiki/Polkit
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        Wants = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
