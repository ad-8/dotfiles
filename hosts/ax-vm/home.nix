{ config, pkgs, ... }:

{
  imports = [
    ../../home-manager/all-modules.nix
  ];

  # pkgsCore.enable = true; # enabled by default, see all-modules.nix
  pkgsDev.enable = false;
  pkgsExtra.enable = false;
  pkgsGui.enable = false;
  pkgsWm.enable = true;

  configAuthAgent.enable = true;
  configGit.enable = true;
  configGtk.enable = true;
  configMegasync.enable = false;
  configMime.enable = true;
  configQt.enable = true;
  configSecretService.enable = false;
  configWebApps.enable = false;

  home.stateVersion = "25.05";
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  home.packages = with pkgs; [
    # all pkgs are listed in the home-manager/pkgs-*.nix files
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo 'home-manager seems to be working :)'";
    };
  };
}
