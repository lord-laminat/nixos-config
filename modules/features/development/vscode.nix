{
  flake.modules.homeManager.vscode = { config, pkgs, lib, ... }:
    let
      noctaliaEnabled = lib.attrByPath [ "programs" "noctalia" "enable" ] false config;
      noctaliaTheme = pkgs.fetchurl {
        name = "noctaliatheme-0.0.5.vsix";
        url = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Noctalia/vsextensions/noctaliatheme/0.0.5/vspackage";
        curlOptsList = [ "--compressed" ];
        hash = "sha256-aTSk3yYkBw5GrD0CbRL2wo3SlBffzBTDe1pZoZa1URQ=";
      };
    in {
      home.packages = [ pkgs.vscode ];
      # Noctalia updates the extension's theme JSON, so install a writable
      # extension with Code rather than linking its directory into the Nix store.
      home.activation.noctaliaVscode = lib.mkIf noctaliaEnabled (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if ! ${pkgs.vscode}/bin/code --list-extensions --show-versions | ${pkgs.gnugrep}/bin/grep -Fxiq 'Noctalia.noctaliatheme@0.0.5'; then
          run ${pkgs.vscode}/bin/code --install-extension ${noctaliaTheme} --force
        fi
      '');
    };
}
