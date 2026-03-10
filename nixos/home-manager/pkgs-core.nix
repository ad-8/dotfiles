{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    pkgsCore.enable = lib.mkEnableOption "Enable core pkgs";
  };

  config = lib.mkIf config.pkgsCore.enable {
    home.packages = with pkgs; [
      babashka
      bat
      delta
      emacs
      eza
      fastfetch
      fd
      file
      foot
      fzf
      htop
      nh
      (nnn.override { withNerdIcons = true; })
      psmisc # provides killall
      ripgrep
      starship
      stow
      tealdeer
      tokei
      tree
      zoxide
    ];
  };
}
