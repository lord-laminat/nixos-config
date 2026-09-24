{
  flake.modules.nixos.terminal = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.ghostty
    ];
  };

  flake.modules.homeManager.terminal = { pkgs, ... }: {

    home.programs.nushell = {
      enable = true;
      extraConfig = ''
        $env.config.show_banner = false
      '';
    };

    home.programs.starship = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
