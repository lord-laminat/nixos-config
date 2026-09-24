{
  flake.modules.nixos.compatibility = { pkgs, ... }: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
        fontconfig
        libX11
        libICE
        libSM
      ];
    };
    environment.systemPackages = with pkgs; [
      glib
      bubblewrap
    ];
  };
}
