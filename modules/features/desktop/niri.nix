{ ... }:
{
  flake.modules.nixos.niri = { pkgs, ... }: {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [ brightnessctl xwayland-satellite ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.niri = { pkgs, lib, ... }: {
    home.packages = [ pkgs.yazi ];
    xdg.configFile = lib.mapAttrs' (name: _: lib.nameValuePair "niri/config.d/${name}" {
      source = ../../../assets/niri/config.d + "/${name}";
    }) (builtins.readDir ../../../assets/niri/config.d) // {
      "niri/config.kdl".text = builtins.readFile ../../../assets/niri/config.kdl;
    };
  };
}
