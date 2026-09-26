{
  flake.modules.nixos.terminal = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.ghostty
    ];
  };

  flake.modules.homeManager.terminal = { pkgs, ... }: {

    programs.nushell = {
      enable = true;
      extraConfig = ''
        $env.config.show_banner = false
      '';
    };

    programs.starship = {
      enable = true;
      enableNushellIntegration = true;

      # ANSI colors follow the terminal palette supplied by the desktop shell.
    };

    programs.ghostty = {
      enable = true;
      settings = {
        command = "nu";
        background-opacity = 0.9;
        background-blur-radius = 20;
      };
    };
  };
}
