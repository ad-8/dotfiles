{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    pkgsDev.enable = lib.mkEnableOption "Enable dev pkgs";
  };

  config = lib.mkIf config.pkgsDev.enable {
    home.packages = with pkgs; [
      bundix
      clojure
      clojure-lsp
      direnv
      geckodriver
      gh
      jetbrains.ruby-mine
      jq
      leiningen
      nil # nix language server
      rubyPackages_3_4.solargraph
      semgrep # needed for clojure lsp and others in emacs
      vscodium

      # nix formatters
      # usage: <name-of-formatter> <file-to-format>
      nixfmt
      alejandra
    ];
  };
}
