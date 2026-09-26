{ inputs, ... }:
{
  flake.modules.nixos.noctalia = {
    imports = [ inputs.noctalia.nixosModules.default ];
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      systemd.target = "niri.service";
    };
  };

  flake.modules.homeManager.noctalia = { lib, ... }: {
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia = {
      enable = true;
      settings.shell = {
        polkit_agent = true;
        launch_apps_as_systemd_services = true;
      };
    };
    xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
      include "noctalia.kdl"
    '';
    xdg.configFile."niri/noctalia.kdl".source = ../../../assets/niri/noctalia.kdl;
  };
}
