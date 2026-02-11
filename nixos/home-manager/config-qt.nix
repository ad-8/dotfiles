{
  config,
  lib,
  pkgs,
  ...
}:

{

  options = {
    configQt.enable = lib.mkEnableOption "Enable Qt config";
  };

  config = lib.mkIf config.configQt.enable {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    # xdg.configFile = {
    #   "Kvantum/kvantum.kvconfig".text = ''
    #     [General]
    #     theme=GraphiteNordDark
    #   '';

    #   "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
    # };
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Nordic
      '';

      "Kvantum/Nordic".source = "${pkgs.nordic}/share/Kvantum/Nordic";
    };

    # ----------------------------------------------------
    #
    # enable all below -> nixos-rebuild switch
    # then Dolphin/Okular/Gwenview respected `kvantum` theme set in `qt6ct`
    # BUT disableing all below ->  nixos-rebuild switch
    # AND still themed, Qt themeing sucks!
    #
    # home.packages = with pkgs; [ kdePackages.qt6ct ];
    # home.sessionVariables = {
    #   QT_QPA_PLATFORMTHEME = "qt6ct";
    #   QT_STYLE_OVERRIDE = "kvantum";
    # };
    #
    # ----------------------------------------------------

  };
}
