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
      alacritty
      babashka
      bat
      delta
      emacs
      eza
      fastfetch
      fd
      file
      fzf
      htop
      nh
      (nnn.override { withNerdIcons = true; })
      psmisc # provides killall
      ripgrep
      ruby_3_4
      starship
      stow
      tealdeer
      tokei
      tree
      zoxide
    ];
  };
}
